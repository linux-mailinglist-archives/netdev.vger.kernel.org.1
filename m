Return-Path: <netdev+bounces-273740-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILAYHOEzzGlRRQYAu9opvQ
	(envelope-from <netdev+bounces-273740-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 22:51:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD83371438
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 22:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44EC3305BFC8
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 20:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16968345CBE;
	Tue, 31 Mar 2026 20:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="B398pkOb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE7918859B
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 20:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774990183; cv=none; b=XZnlgYwxEouUTBa1ZNn4og6yHQkkDCVc6gpl2kSuwIbzAfJ//eCf2Ve+l1lgSQ6+7Md0GJyEMTBVXP2Bu3pLOCOt8xsBp0YJ0FNwtvUeHHI0y9EdvKp/FgNq/RZL+SVNSMv4d5arRI/3Ne+LgzPLylmfc7cuh2rGTgF9bzT+PuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774990183; c=relaxed/simple;
	bh=q05KO6AWrjG/PgJFYBIJXv518zshm1joyl8stcuBMMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdS+TSicV7oP7lnVlgs+kEKgaIy7vwjNY2zqSDBd/JH0Q1FGjx9ILMbCJJty0UfpfBcUUd1RGCGxojyom//YJZiXMUJx7Uhj5T3Nlh1obm+pyH71j7mKt+axY9r65vkVIKESJFqA4cI3JmtfNsavJ6DMCfJVWfAI/YEUwDap3/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=B398pkOb; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82c20b9fb15so2768488b3a.3
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 13:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774990180; x=1775594980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5A5EjfwtiNR9PDlV9xKftKv8ZO5lHwwX8xQnpG4je7U=;
        b=B398pkObkhSZdWcSJjhwg5Nto9BUX/LWI/4vtIGb2G/mX+6g7sVdHR1DV0NDPmhsGJ
         pUOxjMaqMzcb/YIdXHd259GhM3FCX5SeFZ+yWbNIQ+pLuUsUrfHQ5uDsyBApnrPJ3+YV
         FC+kcEYlkzxyz6dZhlnFrjQL9JSjRtZPPhCWMSPOxISJk42Hc0GrXmrYiIvy32us0s8o
         7wE44ePYFPfaAxpD+qmt6Y/JH10V0y1W2rARlOYx1HHypZQ75gxDOLtx0ybvUUIFpO3A
         IQ6iRmo9z3xhiN/O+jzrtOgbclSaiBj0uDEMulZKxSk5oh020jysXML3NC2CnECe/NQv
         W99g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774990180; x=1775594980;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5A5EjfwtiNR9PDlV9xKftKv8ZO5lHwwX8xQnpG4je7U=;
        b=rWQw81t8t9nXWVzHhTqwj19BjEcRcPC8lIz36al4l4d09LRbtfBONuKWuZOpskj4gs
         aa0sSJkwnuZYFhzNMGN7nidglDsdHyO6zqS/+2/d6f8pu0DN+dhDDuPIQY/Vd9ELEdLp
         gxVljb5+VWQckDXmpGm67cQcKUt8IBW9bYCLsrLqqT60tHVddN/4qCB2AURPMvJuSe/5
         ZetCybD960k5hp7GsGrgpSCz8kxk0VPeNgLQzKGs4Zt9u5vRy502xbPIhjd4r122gs2P
         UVt7+LAGL7eAG8uQ4UMNmyd94t7aK1RERHo6ov3Yyn54/OA0qI0arGNRCKc+UEW3uAKO
         qfaw==
X-Forwarded-Encrypted: i=1; AJvYcCXJxBqBIfbkrRcqgXa4z3210fKhVV+InuhzGtH5gfUr69WOH0pwk/vfH5U0u90x1paGicvC9NE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2T2+H1PiOy8czmV/z6LKkUBjFhm3Zl1SFgVErvTZgEiQRICKV
	3lY/6S+8BX/+6K8igitpW2MQUDHEZu8oHhI72AR12e2Ql5TKABlGDWgkBiA2zO2gVu8=
X-Gm-Gg: ATEYQzyYUEfTEap7F8XW/3wV4wplsXfoVrVPCwE1yny7i0yPBV7uUqI5b2C1goFeP1P
	4UzaLl+nE5KEeMof4eCDp4aH+ab9pf66LSewK0Hx5vrzsVc/s96H1I6j97yMEFnfEnKxfAAAsR5
	0H6L5zd3xzmQlAUHg9qcKuhedOPW4dBFZptoyqMxtGWPHo5ym1RMy6pme5ufRyP3CWDQhAxq7wn
	iqbgbZxcRHckh6FvowO3/dk+IvLvn+0ODp3Vj+YG1Od9m2tLYYhi3+FHcBBF4us5o/1tpzHiwVV
	YGMPfNbolitZCDpu4/KF6Lqf/eYlE5f/vxdnoOl7jicczwcER7gsz/ABLdL0ewDIEvFLezfVxFw
	ypqICTZVJbwxjb1IWNmIFyF8uDsK5mwHgx0URTaU55L4xAa32x2Qzcu9NzO+agJN6zeY+yMU/s4
	pZAIc=
X-Received: by 2002:a05:6a00:600e:b0:829:7d31:dd99 with SMTP id d2e1a72fcca58-82ce8ad166cmr912616b3a.38.1774990180603;
        Tue, 31 Mar 2026 13:49:40 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:1::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cdaa4c3basm3171819b3a.37.2026.03.31.13.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 13:49:40 -0700 (PDT)
Date: Tue, 31 Mar 2026 13:49:39 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: drv-net: update the README with
 variants
Message-ID: <acwzYzMoKSoDqnaf@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
	linux-kselftest@vger.kernel.org
References: <20260331001930.3411279-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331001930.3411279-1-kuba@kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-273740-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dama.to:email,devvm20253.cco0.facebook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1AD83371438
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 05:19:30PM -0700, Jakub Kicinski wrote:
> Test authors need to know about variants, existing tests don't use
> them because variants are relatively recent.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: joe@dama.to
> CC: shuah@kernel.org
> CC: linux-kselftest@vger.kernel.org
> ---
>  .../testing/selftests/drivers/net/README.rst  | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)

Reviewed-by: Joe Damato <joe@dama.to>

