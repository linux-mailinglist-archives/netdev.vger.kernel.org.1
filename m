Return-Path: <netdev+bounces-261260-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJzFOSoRoGnbfQQAu9opvQ
	(envelope-from <netdev+bounces-261260-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 10:23:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 619511A34E6
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 10:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF05F3072465
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9673539E181;
	Thu, 26 Feb 2026 09:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xd5G+ZeI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E06639E6EE
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 09:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772097773; cv=none; b=lMusUl1lZ0xXmQZml/0jXWirarL4OXmbgQhnFIL+iBhjtW+0jrmuER+rHIEJ2BF06ipPVjSOZekGsoBEpXFkcFqz8usFtPXEAebe75lmRyoLqeTSEGH9YZREL+VoCt4tuwkONFnQxIOEMuT8ZQAzi/dkkGGeV0OOR7mx8B1r4Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772097773; c=relaxed/simple;
	bh=8UXEEY78JgIJo476jNFn2ZS8ebZG6/2oNY53ZJEgYO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tyz5xD/bdnS0gXxkBR4qSLKWIHO8So7UDI2tJz7zO/hU3fe/AdYkrseqSIbXSYcprpsIEV+Bag/2sxalzJ7bGD0FN/bzm6/r2ZCTej47tXbK0LjCohkB21XL1WJ2v4w3VxZ2/CafylF32TZtY/M/nGr+2/kqueUR8hVIMqaZSf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xd5G+ZeI; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-483a233819aso6659925e9.3
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 01:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772097768; x=1772702568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Fi/8raflhbrprvHiDe2P6OVjgFKHTkfZNPmoq1Ca/k=;
        b=xd5G+ZeICfCxedsy6gsAiDxNpOcxL+xqSxryfu55OWSCdmL6bO3mV32PMO5PHriuVt
         8xNOV35qrXYOGszokOk6wzTZvRw3yoNKg+MLi4dLeNKuYQy4mEOkUTBUAaULSjTzZem9
         ZtiQSXEYfXIoGm6DIhGY/VWJ1TPxJY/Q9XFix6+HA/P01WfeqKhOvYSCj+oNs4Hx0s2V
         AjLdYsRLn/HbCbzZ2kL8+OTfKT0GFrmaKKnrKj70eOR9wnnZpxroHyWm0+vgD2YBgU/a
         X1oV7NR85AzJ9+jP7JVpF+yUf+lmVB7NLfU5aRtEG91XSAmD9lCbeeqqT41YyQkNqVUr
         oy8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772097768; x=1772702568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Fi/8raflhbrprvHiDe2P6OVjgFKHTkfZNPmoq1Ca/k=;
        b=QGQ8ZzgzHm1jLgohStd13lPIbRbrPzM+aYVGTOFhb93kiueDevQrGYfPrU+TsCOvaw
         HINdNnEj+1BGO+z1mtoReB+faIMGLnMFk21qEPmG/gdkTGQBvWj8v22f6lPYOb2EOCnb
         0ovNjNVcVNFiTUcqRkYzUKomWfhimtPI/VZk1MQ8CJ/harE4+/Z3JWuBhg6Y9/a2z7Od
         ttAB8JXVkP7lQ6KZGtUvHFNAosqE9n69EJb+xaRWPyXunNK9Ksg2Bpigsz3dapnzADXz
         d+g2/OYNaY5Qb5+GWHYSlUjdktlAcZ1q1qvM7GyaOPYL+Z9ihXPAzz45BdE+/HBsgjQH
         PJqA==
X-Forwarded-Encrypted: i=1; AJvYcCV1zzaziaoyjAVrpSWyjSEDDZeO5fE6XR+8PwcCidpZKftl9DYbFgyED2MKzzFGfsYJdFgnQRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvdx2R72lFkCm+LSAk+W7tjPPs28mX4OuI6V+hFaBMVJcEsg1i
	tZmtQI5r5878w6EwZOh97sKe5pD6F0NyYBoNwq42qHEnouCoWtTeZAW8Qxn0unX2nOA=
X-Gm-Gg: ATEYQzwJjw0DfT4yt/EKh2ALlG1eODtdiQvJuoUTBv29f3xMxpCft/sFROvMQ8dxe+J
	QJoWz/5MB6ZpQkWQRNG9WG006dcAk6vgTOq4zXOqAJzzAKKeJjmQJNYfd3MyDUUr4OzJNigtmj4
	HjnM+rF6hD7a+9DnVzeOQUzHHp0UBgnYLFs37le5nJyEgDtMayHQBpUr5O/GPru0J6pWlE7zEC2
	CWyUWvDLjm9JJK6p0f3vWLA0aY90AevcREEWTduUfEndSLY3XswaJOMBm+DtMEHFcO/NLIJlptp
	8lNEJupOl0W7qix8V+a/mMfmPRq80aDv6HJOa5XjmJa9X1V75B3PIHAIpPF6ta1prKCOlLrCiF6
	V5eohTq0UD63GSDlT8007BwVysD80Dpp1c0CpgI2U8Xg7z3Gnm0bDXoMPfd+MrS6G3wt0/bcc4l
	P2az1yfUtYKENVHGMweMWgHG8igeq6
X-Received: by 2002:a05:600c:5250:b0:483:9139:4c1d with SMTP id 5b1f17b1804b1-483c3db85b0mr23915235e9.14.1772097767976;
        Thu, 26 Feb 2026 01:22:47 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439934cc51csm8305010f8f.3.2026.02.26.01.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 01:22:47 -0800 (PST)
Date: Thu, 26 Feb 2026 12:22:44 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Zeeshan Ahmad <zeeshanahmad022019@gmail.com>
Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net v3] net: core: failover: fix NULL pointer dereference
 in failover_slave_register()
Message-ID: <aaAQ5JrrDAVOByeb@stanley.mountain>
References: <20260226085601.11343-1-zeeshanahmad022019@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226085601.11343-1-zeeshanahmad022019@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261260-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.carpenter@linaro.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,stanley.mountain:mid]
X-Rspamd-Queue-Id: 619511A34E6
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 01:56:01PM +0500, Zeeshan Ahmad wrote:
> Smatch warns that 'fops' is dereferenced without a NULL check.
> While other callbacks in this function properly check 'fops', the
> rx_handler registration does not.
> 
> Consolidate the NULL check for 'fops' at the beginning of the function,
> before it is first used in slave_pre_register(). This ensures 'fops' is
> valid for the entire function scope and allows the removal of redundant
> NULL checks later in the function, as suggested by Dan Carpenter.
> 
> Fixes: 30c8bd5aa8b2 ("net: Introduce generic failover module")
> Signed-off-by: Zeeshan Ahmad <zeeshanahmad022019@gmail.com>
> ---
> v3:
>  - Move the fops NULL check to the top of the function before any 
>    dereferences occur and remove subsequent redundant NULL checks, 
>    as suggested by Dan Carpenter.

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


