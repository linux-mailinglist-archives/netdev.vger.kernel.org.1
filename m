Return-Path: <netdev+bounces-271066-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GL/5GmCPwmn/ewQAu9opvQ
	(envelope-from <netdev+bounces-271066-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:19:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B94DA309324
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DC0730A581B
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 13:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926483EF659;
	Tue, 24 Mar 2026 13:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="oVZK9Ujd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27184390999
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 13:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774357557; cv=none; b=uXGfdnfW6/D7wJEf4CvDM8wvzkU9Z07qynQO7uJSZzmB38CRbKf0IwUJyhD8c5aHsceRxUyReTcjf8BNSOf9Mehi8OlTuZkopquia/57nR7zdJJRQkJ2xpzPxiXvVmdCEVwHgM74ZRaMqiqyl4nDhgunHBBsMB9X6ae1Mid77V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774357557; c=relaxed/simple;
	bh=cw7XrKGnbZgtS8pgMWwXTOKSgj52ibjy+qLdH1G/JKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OgbGkWE+vd9buTlBB167VswRr0JtSkFXbe0QmLkAhEEZ/HADSaJBFti5CZAUPPX6wwUtlBi2QHHP6MwknNV+KnAIohrESDKux6QAgnq4qtD5frVcSl1a53XcjU/ZxETjQmCDL979klsLQNR9qd7zCZodb8aFKFYwRp3uX/2uR2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=oVZK9Ujd; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43b48ac2727so943708f8f.3
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 06:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1774357554; x=1774962354; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cw7XrKGnbZgtS8pgMWwXTOKSgj52ibjy+qLdH1G/JKw=;
        b=oVZK9Ujd78g0Pee4oP9+FcW9HkdDEYJlXIyPt7P9zsznQ7tleTZLYqY9mZpwaNfzcD
         vvd5aGwpceZu+h2owPWJYqbCYZZxib7wkxYkVWxOIsufLK39khk9o5FTThQN8Qy4y5EB
         YiA1V8w7YXUDiu4bLWsRK1GOKGWGfvL8HT2JbtpIc2RFfRfwwuaNZ7kHgLgWCCji5JEp
         b0Og8mAZ+oawtXJXusLXtQCwbNUoEitcpGdW+c9bhFm1ixUmksiyxLs2lKlRYxMByLM6
         WpexxVihYehx96+g2pDgi6wXZz6yZ1ELRpkNpOX4mncGvmyZyUk5HZtTToHDDigLmrPk
         Wj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774357554; x=1774962354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cw7XrKGnbZgtS8pgMWwXTOKSgj52ibjy+qLdH1G/JKw=;
        b=eY9G+ss6fLYhqNseZT5QIZVXmkJ9yLnbnEmHUjWuSPwGLaxNi3BKx4Jrjy73GlWurf
         8qT5L6yUiNEwzBXH759X/g7agSmFten9uJqIaVcW4yVJL/GStevvOnAUm0CxeJYeuoWs
         eRBVY0h4IT+2iQwtpTRR8MQ66hEE4vM0Of76UiNa6AafrDQvctClajepT6/PpZHrU4MN
         xmcQ0PKhlkrRgjLXcCnysYALsvIyLO5plhcXmobfDHPS3N4bo7US9/d/BjAuBJWy08XM
         bZxouEJNQpid8qXgs2Q1S1YC62/ofstfS+b9hpXMQIf1P5Yqs7KosluDPr7GZ0zhlaVR
         6zJw==
X-Forwarded-Encrypted: i=1; AJvYcCWgD0dUm4NLQppg0nzbVKtioIsuVnwngf+V4HQLVD/JEDlzxy7J32YWtbHcdXWX3OVR7oBWrUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLjTNzA8rTsyEerbh3eeu4pEGZa0LzRjv8g+j7CKzraLVOWBTT
	9v/8KU2Ta7ZBEJWSMavurheIPVnjroRUyzfAdJ/P7Nrmxr0ktx0nnUNkNcGrmqio2Vo=
X-Gm-Gg: ATEYQzxKxzf8WIssUYif8ICEzHg3DM7KMWDSDbAjlWeYah9PC/CMhx1U54+lBU9LgxQ
	m1rpyQ70ZDnm0A8jLZ01sfe5RvLiITcZmOgeU1tEA/l6/Y8Nsw/zhNbMAuIUYD5MsJnjXy3vdwm
	LS4RoRxYm4kLX7IBuzUrGz1oGW3W3xSRHKs9pAOxiAnupOxUDvRARbQqcPnUFn74BA50Brq2N1e
	gKBUcm/N2FXShy76xZxgxM5nLDfkOnGpBqC6Mv4izLxv9SkkkFC7JwkileWMxy3s14bFvHgmgLQ
	P2gKNDIu9SZDNqHysDbrbICx3Dn9REXD4pV+5fdXzjp73EePD2M+YxNQu6296dxlq+9GPs82kVS
	w236R/Lv/YG04azFZX6B/hWaHeC74O0jCP95uXQt0lqQDFCPydG/J7OOav7HdINFY4DyKXm0t2/
	Q6GBM1NTv6hDsd/5NXXkF73qLORQHMQx1nqI9QuDfVgy3+bQ==
X-Received: by 2002:a05:6000:26d2:b0:43b:3d4f:e18d with SMTP id ffacd0b85a97d-43b64287044mr25237105f8f.39.1774357554406;
        Tue, 24 Mar 2026 06:05:54 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b6470f902sm39989765f8f.28.2026.03.24.06.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 06:05:54 -0700 (PDT)
Date: Tue, 24 Mar 2026 14:05:51 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, 
	Chuck Lever <chuck.lever@oracle.com>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
	Cosmin Ratiu <cratiu@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, 
	Daniel Zahka <daniel.zahka@gmail.com>, Shay Drory <shayd@nvidia.com>, Kees Cook <kees@kernel.org>, 
	Daniel Jurgens <danielj@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Willem de Bruijn <willemb@google.com>, 
	David Wei <dw@davidwei.uk>, Petr Machata <petrm@nvidia.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next V8 01/14] devlink: Update nested instance
 locking comment
Message-ID: <owfpttw4n7ft5gisy4gvmd7z22hcafjlcr5i3e4t22j4w3rgz5@drxvpqqmiuen>
References: <20260324122848.36731-1-tariqt@nvidia.com>
 <20260324122848.36731-2-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324122848.36731-2-tariqt@nvidia.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271066-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_CC(0.00)[google.com,kernel.org,redhat.com,lunn.ch,davemloft.net,gmail.com,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,davidwei.uk,fomichev.me,linux.dev,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,resnulli-us.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B94DA309324
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Tue, Mar 24, 2026 at 01:28:35PM +0100, tariqt@nvidia.com wrote:
>From: Cosmin Ratiu <cratiu@nvidia.com>
>
>In commit [1] a comment about nested instance locking was updated. But
>there's another place where this is mentioned, so update that as well.
>
>[1] commit 0061b5199d7c ("devlink: Reverse locking order for nested
>instances")
>
>Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
>Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
>Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

