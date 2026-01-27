Return-Path: <netdev+bounces-253729-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMiFMG9meGnTpgEAu9opvQ
	(envelope-from <netdev+bounces-253729-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:17:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 144B490A86
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 08:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BBC583003723
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 07:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98531267B92;
	Tue, 27 Jan 2026 07:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uat+wywh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A10925D1E9
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 07:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769498216; cv=none; b=V/2lno8f7gXvOmeBq5I6iV6DOzA29jfu81EorauoTYmqugmPIEwJqERiXg+BypHre16DaIyPN9jlK7EHUN0Jd8HwrDSdspmgGhZLc5spezxOWRS++k+J4TVmFxDND/umgcKgMs9wIHM8FfAbpOGkQX14+5CSp/W3el1YsWPJTV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769498216; c=relaxed/simple;
	bh=O4lpA3jRQGFJYxvQ864WpAw3jPoN7vazpgZMK6tCcgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fk0BEbumsHMW0EVhHzqM4Cuqq6nmnnlcf6mTp+OxGWGDMAVsdu6AA84hCz5oQL3sGDTeSaC3Klg1NF6rx7zMOvhxexPgtUsHGVKECxk2FnSt7+iP+fW9yzsIXk9bFHNovPJprFTKifC22euMb2k6BagNmtP+NOB9U8pCa6XMY/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uat+wywh; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-88a2fe9e200so54184246d6.0
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 23:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769498214; x=1770103014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sSGbfDfuOQBUd78sdGxgNuQv31knXCkQLP9+PKDyscg=;
        b=Uat+wywh6aLRwm8ft90sDzzOzLf4S6Z8fc7BN0u/rjchl6joFaFsDg4fWkhWOzGRp2
         orgYgFo/oYpml7p/U5T2e6PVzFfDP8bmuEguEGA90bIshogjG9StvvAWhQTZAL9aA2nD
         LzJCgOVNEt1HerYKC5Rr+u4m6+DcRbyeFFRszk5+qMULGM3lB3DMDcVKOLIJeyXsqRDI
         TCl/Vvhc1p+Td2kw20RTYadDWeVhMVhcSxhpLjZOSchxBfJ4iZHAvxLTCVaZAwdtQ//r
         qZ8PnC2wtVcQpiMb7bQrrJnQkUNRip2Q1hih+7D4R1G8E/Kk3whCHJvQM7cz/Q2T3fa+
         p48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769498214; x=1770103014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sSGbfDfuOQBUd78sdGxgNuQv31knXCkQLP9+PKDyscg=;
        b=AE9rlESrZNDV9OKj6a2/siwt9IyeqRTJ4BARk1okZFVDflx4/yWLEpDrkQsGrR2vHH
         zwPv2Cy1ltgx6gvTiptLKmpaaw+Nx71xvee1jEiQHRGKT2fK50ss18znv8p7Z1Z/JtPt
         uyR7q8Mxx/CNVFIoDZewAIZC812hrorJbMs93MADX/CfE5vGk/5Ksi2pO0hdZuRKw4UM
         H09sRDrqx1i1zKqVUO1KuKn1G9nQj/TjWOC9FI2WmGr3jCFznR47SZ5f06mUeFK7jf3X
         KMPMBNNeCMnEB2AodC7c4QBNk2/QxtCGrZvBmcyl4kSN0eo1mmyPpYbBUU1RIQxcXCiD
         RrdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLXR+w8n7tsCfMqoDxPZOSGeRjJQdoJt4VSWbeGP2F2HmmERTx3YabQlAIm9CeE0I2T3k0Yss=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOKtzF0XUOh2h4ZAm0isoHCS7f+V9w7xr5na0Vgq1Ya7KLDFX5
	bPYFwQIUA58YvbI7sL+9rnOx2TNWscdJb60urvOP9S0famZGeWi97X5/
X-Gm-Gg: AZuq6aJ9AelWsVUe72/2sDzuXvu1yTUqRx7VfbktrAJ6RvXliIabNb5hyxSOETweqS/
	TYaBQLmWzAD5TUXLRTjeedZizqjTNti9O98Vvew8O3X0EodxABMhEj2XhaARloSYp231loTfJ0J
	5IWx7omG3kvUz+jA2W5tblTN6FhQDCiznMK05YmFPs+9D1cXalrvgqm2zGzqUTWqEvai+69EKvU
	8s/cVh/TKwwsh9ynQV3w69t83w+4Tv2QTOlXKDBNirkHyqfi8PS52eP1aEGHEgWSQEZd+dXVTb8
	2z9jsIaII47JyY9mCu+vzxEwGih+OAR0EbEYx0/HkH3PBCyhY7rFXcZEGlIzHKzc0YJMWhf3cjZ
	YNrOmWosWYxZ1MdvLfe0URH8TGUVSuuzy2XE9jDXo7syyGpei7GASB4PmXkC4lD5+DyPjjxImnF
	5Wdeach4c=
X-Received: by 2002:ad4:5b89:0:b0:894:6622:a6d4 with SMTP id 6a1803df08f44-894cc96202cmr9307226d6.61.1769498213952;
        Mon, 26 Jan 2026 23:16:53 -0800 (PST)
Received: from pek-khao-d3 ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6e37c823bsm1221262185a.2.2026.01.26.23.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 23:16:53 -0800 (PST)
Date: Tue, 27 Jan 2026 15:16:46 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: kuniyu@google.com, andrew+netdev@lunn.ch, vladimir.oltean@nxp.com,
	s-vadapalli@ti.com, linux-omap@vger.kernel.org, rogerq@kernel.org,
	stable@vger.kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	edumazet@google.com, davem@davemloft.net
Subject: Re: [net,v2] net: cpsw_new: Execute ndo_set_rx_mode callback in a
 work queue
Message-ID: <aXhmXkWqrMOTCgnH@pek-khao-d3>
References: <20260125-bbb-v2-1-1547ffabc9d3@gmail.com>
 <20260127030556.3839208-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HTNmXs20Xq35qd8U"
Content-Disposition: inline
In-Reply-To: <20260127030556.3839208-1-kuba@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253729-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 144B490A86
X-Rspamd-Action: no action


--HTNmXs20Xq35qd8U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 26, 2026 at 07:05:56PM -0800, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.

Thank you, Jakub. This is indeed a valid point, and I apologize for overlooking
this issue.  I will send a v3 to address it.

Thanks,
Kevin

--HTNmXs20Xq35qd8U
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEHc6qFoLCZqgJD98Zk1jtMN6usXEFAml4Zl4ACgkQk1jtMN6u
sXGOLAgAqOgEQOMZa8O38ImuMB1qyHJitTRzmWCu6eNKkTEuHm525osQVFQF8YJr
9sjzpJkJwYkpASyr0O15t5VQtwhbO43vU8HTS1JldIzSaDnQK9yDWO9cuqDhn6VP
aOp5aLuActYM6GfK8jqWQdgEn0Pz+xpBkryqR5/4IRWfJu5t738w/E0RBU7wEuZe
OM7Z+DIjEkwHea4Kijt+8vTPUhawi+cKoqibQRX/VRz5Pre6ujAdKk5WgZ842rsn
Sn37YqLLr65A5VPS3sR6bv3VkY3oT9RMVkckVJXlwllQp7VkDDlt7hD17d4yd07p
k6HK2+y0OqCJiowbPJGs32qiY7ow2w==
=v8L2
-----END PGP SIGNATURE-----

--HTNmXs20Xq35qd8U--

