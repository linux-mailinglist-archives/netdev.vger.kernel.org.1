Return-Path: <netdev+bounces-246535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19102CED89A
	for <lists+netdev@lfdr.de>; Fri, 02 Jan 2026 00:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE54730057FA
	for <lists+netdev@lfdr.de>; Thu,  1 Jan 2026 23:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFFC202997;
	Thu,  1 Jan 2026 23:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="oxuv75dz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TpouiE+p"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79902A1BA;
	Thu,  1 Jan 2026 23:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767309087; cv=none; b=MGiiAdmOAcbsee7Gtz/mcjve2tcK1dKn91LTxD4rkmymJPxOUCOP/WK+yhV5JvFtlI9OsTs0f5LAMPHdEXcYtxQtF0Xi8l/6ZO6tkMDOGxXC/hi5om/GY9C7FsamiSIQ1IbMZr2XzI88qlXNLpZUoF7dUkXW1MZ15TyN18yK9Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767309087; c=relaxed/simple;
	bh=PPrXV2IR7jc7OCJJVoOeWTZ7Vt8X/2RmDuBUK7l8B7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iJJhfba0Atc9k9Iy+wQO7eZIVxSUqQVREBjMHW96j9BCD3rPaooUTZWSepDtUsWhw1Hioq1NHtXJl1iYbtiua1sxf4m3pm0hBjP33LUVw/EzqzWPWL7sYnGjDoPTnKQ3VDNePXS0AiVJqkE/WvAumXttQw1LQitzBRqV5nlV35U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=oxuv75dz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TpouiE+p; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id C3A231D000B2;
	Thu,  1 Jan 2026 18:11:24 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 01 Jan 2026 18:11:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767309084;
	 x=1767395484; bh=QoH60nt6jj+dad1rA/Vjn5lgtgqut6j5eqlPqXVpRww=; b=
	oxuv75dzbHz06mxgoCEN7wngFhLjxmndSMIZixRpcZ4nSL3uCFLBfKfCTUNkiyJ8
	qHid1P/h6LIOVJvhxwi+fvsKtKu18CgAKYbp1yQ7iZn/l/Ue/spHfVMKzHnTFPtR
	Srezhvnb0tr4L8mwHX7kAPlc7Q6thMm1+dGV84PbVnng2ArMl0t2DCfUrfUx5yAx
	tOr+3RAqtF/a0jzhvIvkasgIqARRgRpUBgSzPkaFJuk/sqW3qVGpPJ9Z8EK9rm3s
	PDVz+TGbEJuhKddZHVzmscazzeu1C4yTP5bKwy/pwEaSDCQbyAuad4TrrVPRWsEJ
	Zq88yfziKvsT2d7ZMQT4aQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767309084; x=
	1767395484; bh=QoH60nt6jj+dad1rA/Vjn5lgtgqut6j5eqlPqXVpRww=; b=T
	pouiE+pc9xg8vAbTHYWYlZwYVqHGGANPVgnRt5nCYP/7hBe4ycX9dWqpzTOJbsDU
	pMMBEKtt32fMlKQounBFDnEcsQc+uZWMJH1HiBB+HDrAxWiMMzr2O0BQYPDtbwAc
	eajQAh56Oul+DXpnWuPa3wdoPvy7S+Fr1v3ROfLi7A5uQIH/Wrq1tH4R4s3zc10U
	DrxodE3VIN9JfozOKmOVN1/0e/YfRhxOVx+SmmJsOkF4EPROkO6m2QRnLOK6MGal
	R3w5rlSKk1w01PVTj5rU+gCGA8Wk2n3ftFrYD3IySnR61teEbI26ISxADkiRr7dU
	qNQVd17DfNhwcx580tQiA==
X-ME-Sender: <xms:G_9WabTNrQiiW5ERqHQoZo7sYHJZo8i5NaVEbEQH9roJxJBB3B4ayg>
    <xme:G_9WabDTOPU787N8clpMlnD9dGzSeyDRhGR4QgwjZs3_Qy42jG5ebPAXLrGbdULPn
    xe56xWHRqTA1baQtE7vB5xuspWCOLbJ7DvZe7LEhi0bzTHL7F3jaMQ>
X-ME-Received: <xmr:G_9WaaKF8DQ-CtpP8m0hvTtYlHzI-BHYWAXMCshps207mmC62CTUtlIv6pBOQ0FcL7_xSNHZxtMFCm2vzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekjedtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertd
    dtvdejnecuhfhrohhmpefvihhnghhmrghoucghrghnghcuoehmsehmrghofihtmhdrohhr
    gheqnecuggftrfgrthhtvghrnhepfedvheeluedthfelgfevvdfgkeelgfelkeegtddvhe
    dvgfdtfeeilefhudetgfdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepmhesmhgrohifthhmrdhorhhgpdhnsggprhgtphhtthhopeduuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepuhhtihhlihhthigvmhgrlhejjeesghhm
    rghilhdrtghomhdprhgtphhtthhopehgnhhorggtkheftddttdesghhmrghilhdrtghomh
    dprhgtphhtthhopehgnhhorggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohephhho
    rhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhmohhrrhhishesnhgrmhgvih
    drohhrghdprhgtphhtthhopehkuhhnihihuhesghhoohhglhgvrdgtohhmpdhrtghpthht
    oheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohep
    nhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:G_9WaeBEtUas5hz0s-BfvwtDwWwXCZqPEVCy0gmc3SKcwwyBTORTPg>
    <xmx:G_9WaXuuWoVuIM7PJxLQDEsJ5rklZlE5yV0rO_kxn9vRr7roSTl-Nw>
    <xmx:G_9WaUQ39IBenjAH59oH1AFe2E87BhYH3PeM5O0dXkxIsDDD812Myw>
    <xmx:G_9WaWLZowS5Kj8df7jbiT-m-LQYzRdXf_hcBU8yRa8tcL39_9UQ-g>
    <xmx:HP9Wack_XcMjbrwQOPgedc88-RkGh9wTIAoqmKkjsGZcdCLlXa287tQ4>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Jan 2026 18:11:22 -0500 (EST)
Message-ID: <b992df90-92da-48bd-91d1-051af9670d07@maowtm.org>
Date: Thu, 1 Jan 2026 23:11:20 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] lsm: Add hook unix_path_connect
To: Justin Suess <utilityemal77@gmail.com>
Cc: gnoack3000@gmail.com, gnoack@google.com, horms@kernel.org,
 jmorris@namei.org, kuniyu@google.com, linux-security-module@vger.kernel.org,
 mic@digikod.net, netdev@vger.kernel.org, paul@paul-moore.com,
 serge@hallyn.com
References: <20260101.f6d0f71ca9bb@gnoack.org>
 <20260101194551.4017198-1-utilityemal77@gmail.com>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20260101194551.4017198-1-utilityemal77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/1/26 19:45, Justin Suess wrote:
> [...]
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 55cdebfa0da0..397687e2d87f 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -1226,6 +1226,18 @@ static struct sock *unix_find_bsd(struct
> sockaddr_un *sunaddr, int addr_len,
>         if (!S_ISSOCK(inode->i_mode))
>                 goto path_put;
>  
> +       /*
> +        * We call the hook because we know that the inode is a socket
> +        * and we hold a valid reference to it via the path.
> +        * We intentionally forgo the ability to restrict SOCK_COREDUMP.
> +        */
> +       if (!(flags & SOCK_COREDUMP)) {
> +               err = security_unix_path_connect(&path);
> +               if (err)
> +                       goto path_put;
> +               err = -ECONNREFUSED;

I'm not sure if this is a good suggestion, but I think it might be cleaner
to move this `err = -ECONNREFUSED;` out of the if, and do it
unconditionally above the `sk = unix_find_socket_byinode(inode);` below?
To me that makes the intention for resetting err clear (it is to ensure
that a NULL return from unix_find_socket_byinode causes us to return
-ECONNREFUSED).


