Return-Path: <netdev+bounces-293459-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id l6URDLBeHGqANQkAu9opvQ
	(envelope-from <netdev+bounces-293459-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 18:15:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D7E617166
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 18:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D7C7301D6A9
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 16:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B1A38238A;
	Sun, 31 May 2026 16:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biERD9Rk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7475A79B
	for <netdev@vger.kernel.org>; Sun, 31 May 2026 16:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780244140; cv=none; b=IZ3Ta48YQSH7BIMDF2VNFHHU/+KHdPgcCwAjuXULzjXy+N7MhhQ8NyIMA0vvRzpui9lrFpS+b8Oti6Xphevm4h1CZf0qLzbi9hP3ni4PLWp213FjYa1LV1XAGeushwVQbNlfZ4+Ezw1UVBhep/hwjrpr37FCto/ECtAppfMdvuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780244140; c=relaxed/simple;
	bh=/yyRRWfp/60UXBX9gCd6uR9PjndX5VlK/EDuZ/CxTGU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ExFmN1fNvaWF+PUwJgOklscAtYTmgViyXgCtKXwUo2wj8HGNL2/3uwSORQvR+Lt1sphlOkOglmmmwKZKc+j0oK/lhSIPyTt5NeAiETkXBP4HrBn7HjBtD3MXaxNjpc+GIvtOqxEjsnu+XwwN9E3WMvZnj7vE1rpyapML7PDCvjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=biERD9Rk; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490a7876f8cso4526505e9.3
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 09:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780244137; x=1780848937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNVMmN3rmllA2oQU/96urbR1HqNbHZ9d5MxR1W2xKWk=;
        b=biERD9RkBYdHZnkSyL0zh9jIiRIvMA6BIfl3nnAtVdfAcJ4k4YLYbGsnW6ESF9B72z
         5Zp7YsVZaykIcp0rBXl6MzAoCfOuv9/QfeX6eBFC/mJRvbcyH0gooZrPbXo74mM4qOIY
         mtPvVkM79MtcRVHbNyACMVUxNcTHsxMT2nCTSxd+HaQVyqEdhCHTxBELsfrrLQkQn1Eg
         BX3UzY9wjNe/ZOVU8/PZc5B6pNs4yVGS2h/7AEc/yYAde0Lw8PSNbJfYgtXRxjROtDTn
         nboX1evgIKa3iFT0ixF3hBt2QmSheyjc3FbzNwGRqToYBMtn9BwhSYLTmpbCW/Z1Y/lJ
         KGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780244137; x=1780848937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yNVMmN3rmllA2oQU/96urbR1HqNbHZ9d5MxR1W2xKWk=;
        b=JsqXf2M5BSKNUZfLdpuB8gj/MXmo3HxwKYnuT4HFpKy8XccVt9ntSU0Lw7aPLxZSXI
         pYWrDv3KF3qujqLILS8vWTyZQh3CepNluk3V6hqsqXY10KjF9+cAW60Ed0dIH73Ib6HB
         ZjM0Vx8/qowyis+SabmDKkpUCOqZe3OWDIXPTNrqMfTbmWjtXwnzNRt5xmeqJhCrS3a8
         tbFRd6O8t6rEnHRULVdDG0r5qP/EhobUBEJGf50Y02tYs73viXcBkPPLjFVHpmmZiu1x
         4La3CyGS8sx6c5lJE8HJtzD6I2jRr9k14B249GYP/pf+mn48xJ1hqrq5siDVM6pZb3/y
         Euyg==
X-Gm-Message-State: AOJu0Yy18i2luGn9qYx+VLJ3l5OvgEMsI/HJ+qVtmDuqdPLkcgGCAWdc
	vhQkKQCSe8sbJEl8u2D9EbGMwgzQZI+4mMlCqYDelGYW9uKycdast6oU
X-Gm-Gg: Acq92OHhEpyKzvzVpGDnhfWd1SD7sgl4qyBB2GPRDDX3v21IfS/x6huwZPucZOrwl5y
	xPVXEgSRQnKUZQQ6a34f1DDL4jb9s8kKW/wBwZRk8vkjHw6PqIFHqPHdp5ub0f8K49FPZWZmGY4
	iqfrp/+59CG7grnfZwdsB8dMn3P2AqgjD9ILLu8Y3gFg+ZC6mIX28IMY8rtsQE3XvfS50MOJXI0
	fOOszgj2J73zvMrRLPLTo2nzpPOh8LVBgBbYifQVNsaskN8EN8fWK2GOXKdv9J7axuK/xMgceLz
	1+1xbXYaFz5BbWE0ntbqWKfCqoFgfWYs08TTFCOlqubtBK3xY73ffgCpG78vYiIiCNgrO+jVg6X
	/sst2YbcOjGzKS7jEc2Ki1/izOUEd5i8PWg17L6DesJvwDerpNLqIZtPz4PxfWw1nGhtx4igLCk
	Zq+pvdEjClPzOExcbWZSIryzSHMjbaj+1d94rcIRHXVbsOZpHC7SxjOnUzwQ1ZH51zc9z4iAg=
X-Received: by 2002:a05:600c:1988:b0:488:aa33:dcbd with SMTP id 5b1f17b1804b1-490a2950c9emr137343035e9.26.1780244136926;
        Sun, 31 May 2026 09:15:36 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909cabfd6esm187661005e9.15.2026.05.31.09.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 09:15:36 -0700 (PDT)
Date: Sun, 31 May 2026 17:15:34 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us,
 victor@mojatatu.com, yimingqian591@gmail.com, keenanat2000@gmail.com,
 2045gemini@gmail.com, rollkingzzc@gmail.com, toke@redhat.com,
 dcaratti@redhat.com, security@kernel.org, linux-kernel@vger.kernel.org,
 stable@kernel.org, Rajat Gupta <rajat.gupta@oss.qualcomm.com>
Subject: Re: [PATCH net v5 1/1] net/sched: fix pedit partial COW leading to
 page cache corruption
Message-ID: <20260531171534.6aae381a@pumpkin>
In-Reply-To: <20260531123221.48732-1-jhs@mojatatu.com>
References: <20260531123221.48732-1-jhs@mojatatu.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293459-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,mojatatu.com,gmail.com,oss.qualcomm.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mojatatu.com:email,sashiko.dev:url,linux.dev:url]
X-Rspamd-Queue-Id: 73D7E617166
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 31 May 2026 08:32:21 -0400
Jamal Hadi Salim <jhs@mojatatu.com> wrote:

> From: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
>=20
> tcf_pedit_act() computes the COW range for skb_ensure_writable()
> once before the key loop using tcfp_off_max_hint, but the hint does
> not account for the runtime header offset added by typed keys. This
> can leave part of the write region un-COW'd.
>=20
> Fix by moving skb_ensure_writable() inside the per-key loop where
> the actual write offset is known, and add overflow checking on the
> offset arithmetic. For negative offsets (e.g. Ethernet header edits
> at ingress), use skb_cow() to COW the headroom instead. Guard
> offset_valid() against INT_MIN, where negation is undefined.

This code has all got out of hand somewhere.
I've only been looking at offset_valid() code.

> Fixes: 8b796475fd78 ("net/sched: act_pedit: really ensure the skb is writ=
able")
> Reported-by: Yiming Qian <yimingqian591@gmail.com>
> Reported-by: Keenan Dong <keenanat2000@gmail.com>
> Reported-by: Han Guidong <2045gemini@gmail.com>
> Reported-by: Zhang Cen <rollkingzzc@gmail.com>
> Reviewed-by: Han Guidong <2045gemini@gmail.com>
> Tested-by: Han Guidong <2045gemini@gmail.com>
> Reviewed-by: Davide Caratti <dcaratti@redhat.com>
> Tested-by: Davide Caratti <dcaratti@redhat.com>
> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Tested-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> ---
> v4->v5:
>  1) Dead code removal obsoleted after removing tcfp_off_max_hint as ident=
ified
>     by sashiko-claude[1]. Remove dead code updating "cur".
>  2) Addition of hoffset at tkey->at promotes hoffset to unsigned int,
>     wraps on overflow. Claim made by both sashiko-claude[1] and sashiko-g=
emini[2]
>     I think this is far fetched but possible. Cast tkey->at to int.
>  3) Signedness mismatch in min() macro may potentially cause build issues.
>     Claim made by both sashiko-claude[1] and sashiko-gemini[2].
>     Go back to min_t() for now. David L. can make a better proposal later=
..
>=20
> [1]https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260530080643.134=
5521-1-jhs%40mojatatu.com
> [2]https://sashiko.dev/#/patchset/20260530080643.1345521-1-jhs%40mojatatu=
.com
> ---
>  include/net/tc_act/tc_pedit.h |  1 -
>  net/sched/act_pedit.c         | 77 +++++++++++++++++++----------------
>  2 files changed, 41 insertions(+), 37 deletions(-)
>=20
> diff --git a/include/net/tc_act/tc_pedit.h b/include/net/tc_act/tc_pedit.h
> index f58ee15cd858..cb7b82f2cbc7 100644
> --- a/include/net/tc_act/tc_pedit.h
> +++ b/include/net/tc_act/tc_pedit.h
> @@ -15,7 +15,6 @@ struct tcf_pedit_parms {
>  	struct tc_pedit_key	*tcfp_keys;
>  	struct tcf_pedit_key_ex	*tcfp_keys_ex;
>  	int action;
> -	u32 tcfp_off_max_hint;
>  	unsigned char tcfp_nkeys;
>  	unsigned char tcfp_flags;
>  	struct rcu_head rcu;
> diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
> index bc20f08a2789..bd3b1da3cd63 100644
> --- a/net/sched/act_pedit.c
> +++ b/net/sched/act_pedit.c
> @@ -16,6 +16,8 @@
>  #include <linux/ip.h>
>  #include <linux/ipv6.h>
>  #include <linux/slab.h>
> +#include <linux/overflow.h>
> +#include <linux/unaligned.h>
>  #include <net/ipv6.h>
>  #include <net/netlink.h>
>  #include <net/pkt_sched.h>
> @@ -242,7 +244,6 @@ static int tcf_pedit_init(struct net *net, struct nla=
ttr *nla,
>  		goto out_free_ex;
>  	}
> =20
> -	nparms->tcfp_off_max_hint =3D 0;
>  	nparms->tcfp_flags =3D parm->flags;
>  	nparms->tcfp_nkeys =3D parm->nkeys;
> =20
> @@ -268,14 +269,6 @@ static int tcf_pedit_init(struct net *net, struct nl=
attr *nla,
>  						   BITS_PER_TYPE(int) - 1,
>  						   nparms->tcfp_keys[i].shift);
> =20
> -		/* The AT option can read a single byte, we can bound the actual
> -		 * value with uchar max.
> -		 */
> -		cur +=3D (0xff & offmask) >> nparms->tcfp_keys[i].shift;
> -
> -		/* Each key touches 4 bytes starting from the computed offset */
> -		nparms->tcfp_off_max_hint =3D
> -			max(nparms->tcfp_off_max_hint, cur + 4);
>  	}
> =20
>  	p =3D to_pedit(*a);
> @@ -318,15 +311,12 @@ static void tcf_pedit_cleanup(struct tc_action *a)
>  		call_rcu(&parms->rcu, tcf_pedit_cleanup_rcu);
>  }
> =20
> -static bool offset_valid(struct sk_buff *skb, int offset)
> +static bool offset_valid(struct sk_buff *skb, int offset, int len)
>  {
> -	if (offset > 0 && offset > skb->len)
> -		return false;
> -
> -	if  (offset < 0 && -offset > skb_headroom(skb))
> +	if (offset < -(int)skb_headroom(skb))
>  		return false;
> =20
> -	return true;
> +	return offset <=3D (int)skb->len - len;
>  }
> =20
>  static int pedit_l4_skb_offset(struct sk_buff *skb, int *hoffset, const =
int header_type)
> @@ -393,18 +383,10 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff =
*skb,
>  	struct tcf_pedit_key_ex *tkey_ex;
>  	struct tcf_pedit_parms *parms;
>  	struct tc_pedit_key *tkey;
> -	u32 max_offset;
>  	int i;
> =20
>  	parms =3D rcu_dereference_bh(p->parms);
> =20
> -	max_offset =3D (skb_transport_header_was_set(skb) ?
> -		      skb_transport_offset(skb) :
> -		      skb_network_offset(skb)) +
> -		     parms->tcfp_off_max_hint;
> -	if (skb_ensure_writable(skb, min(skb->len, max_offset)))
> -		goto done;
> -
>  	tcf_lastuse_update(&p->tcf_tm);
>  	tcf_action_update_bstats(&p->common, skb);
> =20
> @@ -412,10 +394,11 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff =
*skb,
>  	tkey_ex =3D parms->tcfp_keys_ex;
> =20
>  	for (i =3D parms->tcfp_nkeys; i > 0; i--, tkey++) {
> +		int write_offset, write_len;
>  		int offset =3D tkey->off;
>  		int hoffset =3D 0;
> -		u32 *ptr, hdata;
> -		u32 val;
> +		u32 cur_val, val;
> +		u32 *ptr;
>  		int rc;
> =20
>  		if (tkey_ex) {
> @@ -433,13 +416,15 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff =
*skb,
> =20
>  		if (tkey->offmask) {
>  			u8 *d, _d;
> +			int at_offset;
> =20
> -			if (!offset_valid(skb, hoffset + tkey->at)) {
> +			if (check_add_overflow(hoffset, (int)tkey->at, &at_offset) ||

There is no real reason for checking the add.
All that matters is that offset_valid() and skb_header_pointer() are
passed the same offset.
Assigning it to a local would make that clearer.

> +			    !offset_valid(skb, at_offset, sizeof(_d))) {
>  				pr_info_ratelimited("tc action pedit 'at' offset %d out of bounds\n",
>  						    hoffset + tkey->at);
>  				goto bad;
>  			}
> -			d =3D skb_header_pointer(skb, hoffset + tkey->at,
> +			d =3D skb_header_pointer(skb, at_offset,
>  					       sizeof(_d), &_d);
>  			if (!d)
>  				goto bad;
> @@ -451,31 +436,51 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff =
*skb,
>  			}
>  		}
> =20
> -		if (!offset_valid(skb, hoffset + offset)) {
> -			pr_info_ratelimited("tc action pedit offset %d out of bounds\n", hoff=
set + offset);
> +		if (check_add_overflow(hoffset, offset, &write_offset)) {
> +			pr_info_ratelimited("tc action pedit offset overflow\n");
>  			goto bad;
>  		}
> =20
> -		ptr =3D skb_header_pointer(skb, hoffset + offset,
> -					 sizeof(hdata), &hdata);
> -		if (!ptr)
> +		if (!offset_valid(skb, write_offset, sizeof(*ptr))) {
> +			pr_info_ratelimited("tc action pedit offset %d out of bounds\n",
> +					    write_offset);
>  			goto bad;
> +		}

Again all that matters is that the same value is passed to offset_valid()
and skb_header_pointer().

> +
> +		if (write_offset < 0) {
> +			if (skb_cow(skb, -write_offset))
> +				goto bad;
> +			if (write_offset + (int)sizeof(*ptr) > 0) {
> +				if (skb_ensure_writable(skb,
> +							min_t(int, skb->len,
> +							      write_offset + (int)sizeof(*ptr))))

That min isn't needed (same as below).

> +					goto bad;
> +			}
> +		} else {
> +			if (check_add_overflow(write_offset, (int)sizeof(*ptr),
> +					       &write_len))

That can't fail because of the 'return offset <=3D (int)skb->len - len;' ch=
eck.

> +				goto bad;
> +			if (skb_ensure_writable(skb, min_t(int, skb->len,
> +							   write_len)))

Similarly that min_t() will return 'write_len'.
But is that even correct?
The code wants to write 4 bytes at skb->data + write_offset.
I can't see where the offset is used.
All the overflow tests have made the logic far too hard to follow.

I think that whole lot can just be:
	hoffset +=3D offset;
	if (offset_valid(skb, hoffset, sizeof(hdata)))
		goto bad;
=09
	/* Ensure any needed headroom is writeable */
	if (hoffset < 0 && skb_cow(skb, -hoffset)
		goto bad;
	/* Ensure the skb is writeable to the end of the area to be written.
	 * The data is pulled into the skb header. */
	if ((hoffset >=3D 0 || hoffset + (int)sizeof(hdata) > 0) &&
	    skb_ensure_writable(skb, hoffset + (int)sizeof(hdata))
		goto bad;
The call to offset_valid() does all the other checks.
(The hoffset >=3D 0 check is the inverse of the earlier check and will
be optimised away - skipping the second second test which is then
always true.)

If you really want a warning message, put a generic one on 'bad;'.

> +				goto bad;
> +		}
> +
> +		ptr =3D (u32 *)(skb->data + write_offset);
> +		cur_val =3D get_unaligned(ptr);

Given you are doing an unaligned read you could remove the check in the
'offmask' path that the final offset is a multiple of 4.
Nothing checked that tkey->off is a multiple of 4, and I suspect that
is user-specifiable?
I'm also not entirely that the mac_header is aligned.

-- David

>  		/* just do it, baby */
>  		switch (cmd) {
>  		case TCA_PEDIT_KEY_EX_CMD_SET:
>  			val =3D tkey->val;
>  			break;
>  		case TCA_PEDIT_KEY_EX_CMD_ADD:
> -			val =3D (*ptr + tkey->val) & ~tkey->mask;
> +			val =3D (cur_val + tkey->val) & ~tkey->mask;
>  			break;
>  		default:
>  			pr_info_ratelimited("tc action pedit bad command (%d)\n", cmd);
>  			goto bad;
>  		}
> =20
> -		*ptr =3D ((*ptr & tkey->mask) ^ val);
> -		if (ptr =3D=3D &hdata)
> -			skb_store_bits(skb, hoffset + offset, ptr, 4);
> +		put_unaligned((cur_val & tkey->mask) ^ val, ptr);
>  	}
> =20
>  	goto done;


