Return-Path: <netdev+bounces-264489-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2P8TFMK4qWlEDAEAu9opvQ
	(envelope-from <netdev+bounces-264489-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 18:09:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D89B215E32
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 18:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 051F2301F148
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 17:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0973DFC82;
	Thu,  5 Mar 2026 17:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="eH8YCyaY"
X-Original-To: netdev@vger.kernel.org
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E733DBD6F
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 17:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772730546; cv=none; b=ObnMMrRsAuANi0NEVeiux7F0Ldj7zQBKiQ+BUhIDK5js+LY1Ws97oMvnbGWaAkx2427mxqHJhL8Uc5ODIv+8nHrPRuHpOR+JlHYQWXQb93B0oqwv7kKgCnR0KTgHXYPnecD0Fn3B3pxIyzpIj/zwd30Xx7VX5OpHryNwIxOHIZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772730546; c=relaxed/simple;
	bh=WicKWTXtBDYjOUd/R2/CWWN64WSplHTWnfjTydxsBRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j6Ugj4grOKzYbO7RgThnqI2qa7P1iY2L5AaIiobmNsw5SYKKUsF59xX36AuL7TsBI0UfXywChjTQ6N0cmt2B9ZdRHAfbjMAq+lLfbKT+joXBbfTyHRQG3uoCLi6Y+7Q+XzZpWGEiS3b4LYzhJ54oMug1kvpuLzBeS9e3xQlkyPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=eH8YCyaY; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1772730537; bh=80Z7B8uDAmt79h8yXL8xjNd6uSj+eKjWfFvR9JtAjg4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=eH8YCyaYo9Bf/5EaT9fFKpu/0H77lZP8/dS02c8d7kJnL18mYQZx5xU10KFVqtZa4mJMdWEMb7U9GyvSLJz+PWnX6o+zSk2yQu5U0RaEfQxQprC+RH3cNAkkugyxz/a0QuabxjSJ5XKiEMiNA0135QYAJIt3nUP/gVFIMooVgG0TzgAfX4aQk8C34M2ctu2rITJTD3GcQaGQatsOtPld9FiFO+Hu5qyhZcUzKE1EclK8fRaFWH8NgRx0SJHa5v/KQ5ygI+uIo1kllBzXYkDutoN11/T62CTzfIaSbmHzJgUG2vld+yaw5k3u5yURd//YD8+vmZSkuBuDZwytXFNRFQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1772730537; bh=wU8vKE9prUqjFew4X+uefKJys+HtrEyhdWSJRWSsi34=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=j4G/COvED2A2ZjEOMqvZnP6KVkM8G6si2W/ZpmSVNtTWYHv5Bztmag5fICppuoN2iZ3lGl2N/K7Ig+LnKXFoYM6kopzHsbOGpa8sTjp8KyZp5vltykPf+ymnU0k2yvKsq9xzwys2iPrnpQvQcTGzSSOQ5eMVd2zQgIXAXTRBGoOP6TE1fPJLuHAEf9UM44ebxnlFiA4jzRvZXwqlGA+oiWlo17ROyyto25Tedbm/4dIgtglKlV18S+oI6bQKZcEH703GvL1PZ9tE1g7E7beP9y6yo2RW+/GlwIW0r/GlCmpWnh0pqohAbtn2on/bXqXClHW45Qa83JBdqZsQomyp9A==
X-YMail-OSG: 58zR03cVM1mhiFOtwGiz3EYeHLl.c.enYHUsDym.4QSxSgv0TQOZyd58FLaQe0X
 BZ1bjzfD7svfuQ1mm0W1tRv1BwvPYQtBqsvlCvatqlKSOG6nDtqWVa9dyy1CgJ5E3DUBhl.84k2p
 5M6a.bu.QC7u4maxYla9tOneYi7Qe7e7C9w8lB8lVuYPe6sQtxiR_U26FZoWkLEzZAqHQ1JT2QCK
 hKecjgAGhpqPUkYHF0SIEvh3CpOAVQI5PFrHYoy4SrtZjrl6UsuhnqV4YmBPLCNMQJUnQUZo1O73
 D1SWxMhYeROrDXLiwM3l390mkV6HEDKGGBrEMFpUZO.rASrIRSDP_beeTSnP.gEUK71PHutN6Vh3
 TAsd9NB4r8UvUg4h0M06Q9iICSqM9VDb42EaacYm9sMyTGwZAQzL3j4fXZ7iHnKWrX8stxTOXURT
 GvCG38vzvhkHkU_qj25yyCoxCWMkZ7voBRpZslOQHlB.nAdcwRNhIKwA2NbCrKXGROiV_SDVSCeT
 .iCV0dOeWX7N5N77WOAcwWrVWt1oE1FcDhXrjMNub6yIHlcMDAvumGKoc5Ly9Od1gsww52LZoQxf
 82h6.TEvnNUIvGJ_dKfMyeWZiDqxY0HV3ou.zUIcTweeLz4.a_IIvPfamMWTwGoXKzjaZcqS_WAi
 k6hrJqOr9lNKspvaBchjJINK15n1wuBvS..3mqi2YSrYFAj8X7v1Y_z5GILu03MrtgOhosOc..Cu
 hNfUwlM4.BQxjJZcMNuaEOmQWjx0yn205lMErHXvkzU2oGpn4leEO215Or2gQgra583Hng_mRFBC
 LhN3F7Ix5imGXHR6vTSnBt._8_Rdz6vkGYZNK2MRlQI0.V2.IrXVBEsK8lJoHS8vfjHYFh7lbF2P
 CXqqRoA_gnQroakiq2_BB0PEvDPc6ah6GkDIcO0V22KkJBeNpN3FmDOnj.46Bo9K6qivbEWwK8wv
 9_wEJF5pZwR1.S0volPiDReHb7Wmvvrj_07b2DxQys._R5Bs1QADus5yOqWJ.FCIuD9cCfSBOjGF
 Fl.ZQMrDvarRDa7e_whv7lhFMI1OeJ_vSE7hcBFv4mem23J.oPjQJJfqZmEZtJDZbKXZFIb9rrDz
 ygu._hUxWfzQxjJZ84FBKJZqGnh28XqltAD9bZcRhh_FCXFIVKkc1YSox8xSIdRQSdc0q3k3WFVq
 EutdRoQUi.HfVyqy_0bM31AB7NqUHKRtupXmPFsejnJd73LG_0RMemVe8h3UFBQRFisBw_rQDH3U
 5NMGgIhtHNvpVx8y6_NxnLfYo4ZsMsh4URZ0mxCFq43vQkigVKmVeiysZjEJxv9o_ytq.7o3QrAZ
 gkQGFlV1Jv_lauvTQ84I8ZBjbpw419Y1bPJTXSYyOC7DaVu5yS1DbPdYkfNwHazbozTGeWNPmhfa
 wKoS1m2bCWQkF9sGcVxis6uERm0zKyuTsgD3JuASktFPCMqbUM9ZXZgB8RvOvD26bCPSrbUSryip
 PiBKOZSjtJJPNPHHZcgs.fNfQg5WTIbkh_B2T2VQITz4YZfkIGi4tLBQ2OX1MMkCoFKUmv9xLvBz
 PIPQUGSKnKp0Y9YYslgSyakx5R0KbCiuLVJQ4jpvATsec5cC8sP6ITKkJ6D_n8LVNaQMozdIpO6Y
 D9zW._dEQKp97cxExeVddQ4ubD9jB00Z71xsiMfoX55mQmlMOMvacCf1YMS9s9zbIbDnJfEejqNp
 YoIAQhsHV37HSoqp8x7V5RcNrf70ZcBD_P4mz5.5vpH98hI8.G3HeLmx6Mh6zIHKy3w.cBa01IP6
 .JLdBbFV6Y.F8pslbEUkQ5WLSE.HJepXl8rS6HBGWBtOWCV5vr6ngF1tNkNfFv2PGO_8k06meepf
 3mbRWjAntU2JM9nsMRW5EaQKvJJh8opySOq970kwy2VvHSenDw3heEagCWirIAbFFY3J7cFJKjWt
 c1KP1QEcKk2GTfYC9eZEEdfuXZuQEZKh0yYU0c2rqlTXFD0et12z00_YqhSoQkkkarYTFr136VBv
 MiMXciSAMBZT.V9kDvf_IUi_JmkpeFZJE3hNMcWYKLp66XAPunC6OlsVK7Lm9KuLRhdoDgjyZkuD
 QblWCVWSP775fKKFxxWW0gq8VtL0VynsOVdQcGSxDsfrfF2DUEjKhYMWG9WnW8AOi9xXGigJM6Ax
 B.dUV7I2klO4b4ow6IQgQRcMvXiX4955KH08752fKjdXfvFdSoNF8LYt_H34onAWshH.E7XuQFZg
 N.6U42yDnvRLO8dKKa3vi.0emWz8xgkozf4hEEkeywSCtNL7IpriOuBFSpwTpa9KfgjbHIcEY8HM
 cUHXly2A9TM0qK6M-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 47e21ffe-a30f-4249-aaa2-8dbbfa7300a8
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Thu, 5 Mar 2026 17:08:57 +0000
Received: by hermes--production-gq1-6dfcf9f8b-gxljn (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8c0ce0e2307669a8df6950dc02d52ef1;
          Thu, 05 Mar 2026 17:08:51 +0000 (UTC)
Message-ID: <5cdf6bdb-1387-4d31-9dc1-b84a210b5902@schaufler-ca.com>
Date: Thu, 5 Mar 2026 09:08:49 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 06/15] smack: Remove IPPROTO_UDPLITE support
 in security_sock_rcv_skb().
To: Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 David Ahern <dsahern@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20260304193034.1870586-1-kuniyu@google.com>
 <20260304193034.1870586-7-kuniyu@google.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20260304193034.1870586-7-kuniyu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.25198 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Rspamd-Queue-Id: 0D89B215E32
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264489-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[google.com,gmail.com,kernel.org,davemloft.net,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[schaufler-ca.com: no valid DMARC record];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,paul-moore.com,namei.org,hallyn.com,schaufler-ca.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[casey@schaufler-ca.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[yahoo.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hallyn.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/4/2026 11:28 AM, Kuniyuki Iwashima wrote:
> smack_socket_sock_rcv_skb() is registered as socket_sock_rcv_skb,
> which is called as security_sock_rcv_skb() in sk_filter_trim_cap().
>
> Now that UDP-Lite is gone, let's remove the IPPROTO_UDPLITE support
> in smack_socket_sock_rcv_skb().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Acked-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: linux-security-module@vger.kernel.org
> ---
>  security/smack/smack_lsm.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 98af9d7b9434..e581d6465946 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -4176,7 +4176,6 @@ static int smk_skb_to_addr_ipv6(struct sk_buff *skb, struct sockaddr_in6 *sip)
>  			sip->sin6_port = th->source;
>  		break;
>  	case IPPROTO_UDP:
> -	case IPPROTO_UDPLITE:
>  		uh = skb_header_pointer(skb, offset, sizeof(_udph), &_udph);
>  		if (uh != NULL)
>  			sip->sin6_port = uh->source;
> @@ -4301,8 +4300,7 @@ static int smack_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
>  #if IS_ENABLED(CONFIG_IPV6)
>  	case PF_INET6:
>  		proto = smk_skb_to_addr_ipv6(skb, &sadd);
> -		if (proto != IPPROTO_UDP && proto != IPPROTO_UDPLITE &&
> -		    proto != IPPROTO_TCP)
> +		if (proto != IPPROTO_UDP && proto != IPPROTO_TCP)
>  			break;
>  #ifdef SMACK_IPV6_SECMARK_LABELING
>  		skp = smack_from_skb(skb);

