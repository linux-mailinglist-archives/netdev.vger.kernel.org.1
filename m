Return-Path: <netdev+bounces-281120-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4hFUHxHR7GmXcwAAu9opvQ
	(envelope-from <netdev+bounces-281120-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 16:34:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D154669D0
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 16:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43461300951F
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 14:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB2D3612CF;
	Sat, 25 Apr 2026 14:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="POcRUCBB"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034D622068D
	for <netdev@vger.kernel.org>; Sat, 25 Apr 2026 14:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777127694; cv=none; b=h/qpXNyj9FSYO5dXEIpoP6xPFP+0TNm+784FOwwfOYFVg97zPOhLWlodjC87WIjQEcsSMYp8bLz/sTbvKvHsoKKAgAbzGuFpR0JuMkqxOd69CK1mfjkRGJEfrgfEZPBYAiHblw9LG6O7Pc1H9Kup4bQBLlTMdHLNim49+BLo7E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777127694; c=relaxed/simple;
	bh=f5iw195cLpLKf/7r9atvm0GkP8AHLn0x8lV0OmREZ/Y=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=hfFWYSUI7NaXelybQ72ShPCX1j+r3yWzVVLNP65x9d2w+zoNiGFrBjRVyS97rCGYgjDrMUnHZoyLsFOKuv1qO/fIth5UQ+JHuvX7blz32SaY+KEiujdt8aeNNHJr5l5V+b8XQe+22skVfck4TJ9OgCfE5IwcdtjXOWiaxfnWNzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=POcRUCBB; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Received: by dvalin.narfation.org (Postfix) id 18BD4214B3;
	Sat, 25 Apr 2026 14:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1777127245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V6eoI+Q5YMAFhwWdYzQxJXW219gl6YFdQqBxyOL+a/w=;
	b=POcRUCBB5iLtEI37Hm4EOi0x7vLEKQK6XSBuZaRPIn21xi941eMbhtKOdHlzGAZXCEjWn0
	Rm3dbOn5707N87qNZiq6RGvke7Ee8DOHT7uxtGqiiiPCaPpS+S4kFDL38mLWRDKhBAUzv7
	lCg4k1xzPGKH+IVFxt35VG+5x0Ls7vg=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net 1/1] batman-adv: stop tp_meter sessions during mesh
 teardown
From: Sven Eckelmann <sven@narfation.org>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, 
 marek.lindner@mailbox.org, sw@simonwunderlich.de, antonio@mandelbit.com, 
 sven@narfation.org, davem@davemloft.net, edumazet@google.com, 
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, yuantan098@gmail.com, 
 yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn, 
 tr0jan@lzu.edu.cn, wangjiexun2025@gmail.com
In-Reply-To: <80ccaa2c7ce0f72c4555b039217834386282aa0e.1776998957.git.wangjiexun2025@gmail.com>
References: <cover.1776998957.git.wangjiexun2025@gmail.com>
 <80ccaa2c7ce0f72c4555b039217834386282aa0e.1776998957.git.wangjiexun2025@gmail.com>
Date: Sat, 25 Apr 2026 16:22:08 +0200
Message-Id: <177712692887.34614.2289598356887428944.b4-review@b4>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2332; i=sven@narfation.org;
 h=from:subject:message-id; bh=f5iw195cLpLKf/7r9atvm0GkP8AHLn0x8lV0OmREZ/Y=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDJlvzonF+en1Zq/3M/oTvaTSxCEr4lOGksC7K8H1e9KOh
 dt3+zZ1lLIwiHExyIopsuy5kn9+M/tb+c/TPh6FmcPKBDKEgYtTACYS4MjI8LCo5je//uEl2iXn
 RX6bnNyX2PjpQQCnWvfiwhmTm/hUMhn++wkXZ/wobXKxUKlidzc5uPbn6fSfM+TPLZ75Zt25xfx
 KvAA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
X-Rspamd-Queue-Id: C4D154669D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[narfation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[narfation.org:s=20121];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-281120-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[narfation.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sven@narfation.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lists.open-mesh.org,vger.kernel.org,mailbox.org,simonwunderlich.de,mandelbit.com,narfation.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lzu.edu.cn];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,narfation.org:dkim,narfation.org:email,lzu.edu.cn:email]

On Sat, 25 Apr 2026 20:59:16 +0800, Ren Wei <n05ec@lzu.edu.cn> wrote:
> [...]
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Co-developed-by: Luxing Yin <tr0jan@lzu.edu.cn>
> Signed-off-by: Luxing Yin <tr0jan@lzu.edu.cn>
> Signed-off-by: Jiexun Wang <wangjiexun2025@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>

Thanks. I have some minor notes about the patch:

>
>
> diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
> index 2e42f6b3..028cd4e0 100644
> --- a/net/batman-adv/tp_meter.c
> +++ b/net/batman-adv/tp_meter.c
> @@ -947,6 +964,13 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
>  
>  	/* look for an already existing test towards this node */
>  	spin_lock_bh(&bat_priv->tp_list_lock);
> +	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE) {
> +		spin_unlock_bh(&bat_priv->tp_list_lock);
> +		batadv_tp_batctl_error_notify(BATADV_TP_REASON_DST_UNREACHABLE,
> +					      dst, bat_priv, session_cookie);
> +		return;
> +	}
> +
>  	tp_vars = batadv_tp_list_find(bat_priv, dst);
>  	if (tp_vars) {
>  		spin_unlock_bh(&bat_priv->tp_list_lock);

Hm, this looks a little bit out of place. Maybe split it in a patch for
handling the starting part (this) and the rest (the shutdown handling).

> @@ -966,7 +990,6 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
>  					      bat_priv, session_cookie);
>  		return;
>  	}
> -
>  	tp_vars = kmalloc_obj(*tp_vars, GFP_ATOMIC);
>  	if (!tp_vars) {
>  		spin_unlock_bh(&bat_priv->tp_list_lock);

Why was this changed?

> @@ -1342,7 +1362,6 @@ batadv_tp_init_recv(struct batadv_priv *bat_priv,
>  			   "Meter: too many ongoing sessions, aborting (RECV)\n");
>  		goto out_unlock;
>  	}
> -
>  	tp_vars = kmalloc_obj(*tp_vars, GFP_ATOMIC);
>  	if (!tp_vars)
>  		goto out_unlock;

Why was this changed?

> @@ -1478,9 +1500,57 @@ void batadv_tp_meter_recv(struct batadv_priv *bat_priv, struct sk_buff *skb)
> [ ... skip 12 lines ... ]
> +void batadv_tp_stop_all(struct batadv_priv *bat_priv)
> +{
> +	struct batadv_tp_vars *tp_vars[BATADV_TP_MAX_NUM];
> +	struct batadv_tp_vars *tp_var;
> +	int count = 0;
> +	int i;

size_t count = 0;
size_t i;

-- 
Sven Eckelmann <sven@narfation.org>

