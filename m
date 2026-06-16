Return-Path: <netdev+bounces-299757-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oMnxAFfzMGpxZQUAu9opvQ
	(envelope-from <netdev+bounces-299757-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 08:55:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1078B68CAB5
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 08:55:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=VUcLW76y;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299757-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299757-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD299304C10B
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 06:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F679313E30;
	Tue, 16 Jun 2026 06:55:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF4B313E03
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 06:55:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781592916; cv=pass; b=uueLS/P3+nqKRpfH8XlZbT14v3weLn2E0yNCS6vXsbPhXGuepIXOd11vKoi6uw6IM7ILtFFzu7KVYumer121+pfpKyCnB9W8bnlKeTmN5UQ91apyi8XlPpw710rH7b3PPknJyjel0XS96zl0kMkpjapWin6uaa2XscywSGO0cKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781592916; c=relaxed/simple;
	bh=1bmgW04kPplLhjEXr92D7Iv9eRPKZHEw/fLac+zynOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U/nWeHZfizWmJPwK2DhLA5Bc4KZvbjWC7v99TBlX67MrnWh9NqQ2oOTbpkE/j8WISqSMkkNWLmhBDbvpUW6rOKfsBzwsNmwZpF4ytuj+2KCD0GU0YhvgT976UEgS9+TfcDHDs6kohWaBF0oLXbWmmbcj3YLmrX0min/WTiAbWl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUcLW76y; arc=pass smtp.client-ip=209.85.160.42
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-43d26679a6aso2506461fac.2
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 23:55:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781592914; cv=none;
        d=google.com; s=arc-20240605;
        b=iXDo+5jZkwQNMEEvEJpU5tVpTe/dpI5KIaFbVdxYO0+Hndxnr4F/SrKPWdc45ND5xh
         EBi9kpgaXshwUqVOlCUfRSe7t6r+iPWSSFgRUm9IiJNgeyU/hxav4qWrp3QFAdRX3SNs
         C9sFsZiyzRvzWy4yYrLu3PgBVeA8oEcamytVaK2tcqSfWUV+pNj1x8hxOAc0coAmMbbM
         8S/HQhT+OpSSQezL9IoOi8IxmjjiHzZoa4sYnZPz+/WKNXWL1JHE9ivPrMXuTrtGS1E4
         5WIQ/yq8PzDwWI7QJIkXjcUMvHPUGJ14kWSuP8YEi58sm0YQofPRHg5sOh1K6trtROJ2
         xXHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WhqhVB0ZYe3mjxT+REOjwNcUWsDtJmX+ddrr2AgpndM=;
        fh=TtqpSnt1+RYY0ojGarO6gB7U23uZzlu7FPuPabCkarM=;
        b=c8DCccVH2wF8NsDBWGYe9GCB/GQUDdQPHAfdh7U5F1ts79bVAND63u+6+76YAT83fu
         HHcU25FngKBcfLU/zDp1BEObJNUdCabDHRROOSDEV95RnP7QiXNFO/0IW4QPvae7bky/
         B8JyrNCxzUT4L2tB/02Ln0U2UMP/l7HmBdQxo1vhkybb/Sy/7ad91qtYO+TvE15fIN4o
         06L09MpTUy75aFi52Ghcl8VzFpoTbe3QHyNTJ9RFySXoDGjPcMk1da4SmO9YaP7TOnZF
         G5ifX7FuMmaCuI8+BYUJelMcg9pQ6YDLP7dS+7ivrKktKtadNVCO3jL/0unHUlwxavX4
         AKEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781592914; x=1782197714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhqhVB0ZYe3mjxT+REOjwNcUWsDtJmX+ddrr2AgpndM=;
        b=VUcLW76y13/JmqCRp6ANzbH2+XVxeWSDz1BL6Qt4i4mmshmODFq59I42iYnGJN2bEq
         BKegs1eDgtpFvJeyDMB2XLIqUm78lbs/afCALD/G/wyfzsf462fDW4uO38ZfPVnOZ/nl
         8wEDdXt+9xmwkB7/6A/LqQ9rjZ9Y+ieQbc0n6nOyHFLCdf0LVrsCTZ0sEXK7mwMlHfz5
         YMFsSpaweBoaYFoS0UALDad4GbvfPNu4nhPwFsxGMZUtxym+n03oUKzWmoBDEF7Z/RKQ
         4G3YBCshrd3acE/dnf2QPawY9ZB1dAVjrgG8hXDXKF6kxXccPtshn/ONnzSnCGiZ5may
         KuKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781592914; x=1782197714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WhqhVB0ZYe3mjxT+REOjwNcUWsDtJmX+ddrr2AgpndM=;
        b=GcQIFPClsgNKVgqe/MLlsQlKAvQL59E8PtQWXUr0fxPjKdvpzug7QbX7wpmBVEZOHH
         p/Vi0Y3eICnwsffBSKyOuBR0WqVKfZR2avm/l6jqKFICz/NZWC7RCTbT9AikLmOwSnDM
         bAYArZSaYjKujzRMoYHdt2H2SF7HyBEdpZFyMuvHWVJ0/B9wsh0CQRfyQaKFJKAIsGa0
         lBNqO3GJTfi0rNeCRp7KcbHzdJugRQ+w3wBRESjD4t/yEWMxUidW6Lr/rBP6cTxXevoP
         4sZX6yAiwznXxgk9TiZ4J+TdlYwhXIX/LbfmUxGg4X+dZd4oaV+3scM/yrGK8GQZFQFM
         X4fg==
X-Forwarded-Encrypted: i=1; AFNElJ9Q+dL3DzpTsNyyfRljcdthUJsUuQwn5STKDDjq6R6+r4KM3GzjFO1moc1gBcTG04v8f+Zy2iU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd+piDf194Yn0G1ghcJSzNYXtCRnBP6KBow5Ez+iPwB4lDIb4P
	H7hh0eTMctmMDNvb3eHLv771jZfvgTstCWnQh1sET06zDiA9L8sX8JljTksLnBvFDZc22ZDDgR5
	WrcY/2a74z+kvDR+bh/2jCfFCluH+WAk=
X-Gm-Gg: Acq92OHNHJ6Zc6Nu6PYBYIKops0sz5Rbs0PlJpRwJeqF5dv7Y3VqmsFa/CoqCbAngf1
	uqmA8ObI/LiHRzi+8LWBfprAAgDDzHQOfc0XZ0luNd3u68N9revdyfVmzp7lJcCu3Ayx8qDdshQ
	fM2NYaxOfKGozd1fBHWThS/efRwob66HcJP62rAGtxHN8FtECH6fuOuXWcA0fyWOVxZv7jL7aTE
	+TVaSFdzW5PJTMkAoWV/IjssK9T7luYrGA1580hWS8+wT7O0UMVcLBWChbQaaerlb7rCHC/CpHK
	2urKh+b5q+7fHOusPngdqVqLZyVLECM0ASDO74hu0JhpkGJ3IA==
X-Received: by 2002:a05:6808:4fd0:b0:479:ec12:343 with SMTP id
 5614622812f47-4880c565aa6mr2258865b6e.31.1781592913831; Mon, 15 Jun 2026
 23:55:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616-dsa-fix-free-skb-v1-1-fd30b35dcf66@kernel.org>
In-Reply-To: <20260616-dsa-fix-free-skb-v1-1-fd30b35dcf66@kernel.org>
From: David Yang <mmyangfl@gmail.com>
Date: Tue, 16 Jun 2026 14:54:36 +0800
X-Gm-Features: AVVi8CeO9wznloDqxevlQGQurrbZZ6mqY8lgt6RRF8DEikAY6K_isDnrn3fSqAQ
Message-ID: <CAAXyoMNDoZWD6=cvsOwMor9-d33Cxc3UzFqUc0fU+4_JrcaPNA@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: Fix skb ownership in taggers
To: Linus Walleij <linusw@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Jonas Gorski <jonas.gorski@gmail.com>, 
	Hauke Mehrtens <hauke@hauke-m.de>, Kurt Kanzenbach <kurt@linutronix.de>, 
	Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
	"Chester A. Unal" <chester.a.unal@arinc9.com>, Daniel Golle <daniel@makrotopia.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Wei Fang <wei.fang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, 
	George McCollister <george.mccollister@gmail.com>, netdev@vger.kernel.org, 
	Sashiko AI Review <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:florian.fainelli@broadcom.com,m:jonas.gorski@gmail.com,m:hauke@hauke-m.de,m:kurt@linutronix.de,m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:chester.a.unal@arinc9.com,m:daniel@makrotopia.org,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:wei.fang@nxp.com,m:xiaoning.wang@nxp.com,m:clement.leger@bootlin.com,m:george.mccollister@gmail.com,m:netdev@vger.kernel.org,m:sashiko-bot@kernel.org,m:jonasgorski@gmail.com,m:matthiasbgg@gmail.com,m:georgemccollister@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-299757-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,broadcom.com,hauke-m.de,linutronix.de,microchip.com,arinc9.com,makrotopia.org,collabora.com,nxp.com,bootlin.com,vger.kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1078B68CAB5

On Tue, Jun 16, 2026 at 6:33=E2=80=AFAM Linus Walleij <linusw@kernel.org> w=
rote:
>
> The tag_8021q.c tagger calls vlan_insert_tag() in dsa_8021q_xmit().
> vlan_insert_tag() will consume the skb with kfree_skb() on failure
> and return NULL.
>
> When NULL is returned as error code to ->xmit() in dsa_user_xmit()
> it will free the same skb again leading to a double-free.
>
> The idea of dsa_user_xmit() and dsa_switch_rcv() dropping the skb
> they held before the call to ->xmit() and ->rcv() is conceptually
> wrong: the pattern elsewhere in the networking code is that consumers
> drop their skb:s on failure.
>
> Modify the ->xmit() and ->rcv() call sites to not drop the SKB if
> the taggers return NULL from any of these calls. Move those drops into
> the taggers so every callback error path that retains ownership consumes
> the skb before returning NULL.
>
> Keep the existing helper ownership rules: VLAN insertion helpers already
> free on failure (this is the case in tag_8021q.c), while deferred
> transmit paths either transfer the skb reference to worker context or
> hold a worker reference with skb_get() and drop the caller's reference.
>
> For SJA1105 meta RX, transfer the buffered stampable skb under the meta
> lock and return NULL while the skb is waiting for its meta frame: the
> skb is not dropped in this case.
>
> Reported-by: Sashiko AI Review <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/r/20260610153952.1685895-1-kuba@kernel.or=
g/
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Assisted-by: Codex:gpt-5-5
> Signed-off-by: Linus Walleij <linusw@kernel.org>

Better to use goto err, but I'm fine with the current patch. In either case=
,

Acked-by: David Yang <mmyangfl@gmail.com> # yt921x

> ---
>  net/dsa/tag_yt921x.c        |  7 ++++++-

