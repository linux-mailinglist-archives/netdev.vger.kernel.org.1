Return-Path: <netdev+bounces-256457-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJBVBz1XgmmISgMAu9opvQ
	(envelope-from <netdev+bounces-256457-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 21:14:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BABDE666
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 21:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BD86305BFCD
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 20:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7A2366DD7;
	Tue,  3 Feb 2026 20:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKW24yyV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5874013AA2D
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 20:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770149674; cv=none; b=FH+kpiMKrveO28RJvQ33XPkJMtcowiFJo1uoHemIbBMGcg4gkRFQE86/l6V0b2hm3gqhEqwDI7CFoNQog/FNjtVTtBgOD622dvCA3qWCE9ub5zbEhQIQgBdsvQbORg84/CQ/RfAuFVH5h/bvISIk/jLr6DknM+8N9K7UNFBbeO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770149674; c=relaxed/simple;
	bh=j2QlwUFj/m7Pram0Ddqvuqer/FkX/MBZFmS6zUZSYmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LcnotG7V/VM2R8y3gyIhdmunPpP3dfOvHxfxoRRQq5C/93xYa3rvmLWMpctIBflbxoiGYZHINLN+50sxPVVGlqPqCZ+d6HFqdphaL6E/IDC70b/i1B4zcE2+hpVAlKgOb/O3Kcnh3UQTD35Pa6cPnl5XI6cbKQZugt3rJQB1ayg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKW24yyV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F97C116D0;
	Tue,  3 Feb 2026 20:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770149673;
	bh=j2QlwUFj/m7Pram0Ddqvuqer/FkX/MBZFmS6zUZSYmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JKW24yyVisjOu9ZtpiAcSY0M4GQIuX0lPe8dJ/StWSlLQjb+QMbjDwBdFWybR+gsB
	 118ctYuzOco7JKamndbPsE9RU3coDFb/rSQffiErOkVRBln80z4Eu6hU0Dnbf2PnWq
	 QdN/FvU/mlWkUXteSLTw+qK9hJiDCNTsMpnKWW7Y3AeudRdiCsrEHffTH1kzZ25nou
	 rmkE7rkkGUcDK7jedg4LXm2M2Gl3xsXmEFvrUKshDmP2BmNqvDYY6Oj5+qq3Pa+Cdf
	 BqFgxdzr8mvFxcf5DVmYJtxPjquXeyG0S+WU9NouSzl67I2xyFmA0GFzjSSSICrsbr
	 cDK5ubgCY3YRQ==
Date: Tue, 3 Feb 2026 20:14:30 +0000
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] net: add vlan_get_protocol_offset_inline()
 helper
Message-ID: <aYJXJp-hFOyG1tBz@horms.kernel.org>
References: <20260202082200.650516-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202082200.650516-1-edumazet@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-256457-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 78BABDE666
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 08:22:00AM +0000, Eric Dumazet wrote:
> skb_protocol() is bloated, and forces slow stack canaries in many
> fast paths.
> 
> Add vlan_get_protocol_offset_inline() which deals with the non-vlan
> common cases.
> 
> __vlan_get_protocol_offset() is now out of line.
> 
> It returns a type_depth struct to avoid stack canaries in callers.
> 
> struct type_depth {
>        __be16 type;
>        u16 depth;
> };
> 
> $ scripts/bloat-o-meter -t vmlinux.0 vmlinux.1
> add/remove: 0/2 grow/shrink: 0/22 up/down: 0/-6320 (-6320)
> Function                                     old     new   delta
> vlan_get_protocol_dgram                       61      59      -2
> __pfx_skb_protocol                            16       -     -16
> __vlan_get_protocol_offset                   307     273     -34
> tap_get_user                                1374    1207    -167
> ip_md_tunnel_xmit                           1625    1452    -173
> tap_sendmsg                                  940     753    -187
> netif_skb_features                          1079     866    -213
> netem_enqueue                               3017    2800    -217
> vlan_parse_protocol                          271      50    -221
> tso_start                                    567     344    -223
> fq_dequeue                                  1908    1685    -223
> skb_network_protocol                         434     205    -229
> ip6_tnl_xmit                                2639    2409    -230
> br_dev_queue_push_xmit                       474     236    -238
> skb_protocol                                 258       -    -258
> packet_parse_headers                         621     357    -264
> __ip6_tnl_rcv                               1306    1039    -267
> skb_csum_hwoffload_help                      515     224    -291
> ip_tunnel_xmit                              2635    2339    -296
> sch_frag_xmit_hook                          1582    1233    -349
> bpf_skb_ecn_set_ce                           868     457    -411
> IP6_ECN_decapsulate                         1297     768    -529
> ip_tunnel_rcv                               2121    1489    -632
> ipip6_rcv                                   2572    1922    -650
> Total: Before=24892803, After=24886483, chg -0.03%
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


