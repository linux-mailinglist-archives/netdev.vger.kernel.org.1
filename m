Return-Path: <netdev+bounces-100863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9538FC4ED
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 09:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FA541C2167A
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 07:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F58118C327;
	Wed,  5 Jun 2024 07:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="SBgvrLQf"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7455418C33A
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 07:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717573695; cv=none; b=ajpnuUOgMebOCzRVPRv9qVE/6Te0DiIBG6Ldxd3q4NwVTcaiWygdaFYx/v1xAuheBmQHLnLsUB7Dfe+dqqsR+EoAnbsw9xEIhILfPB0lPtHyo+Ms3mXQKV3nNCaSnZwMJSQ2Vc2KHeHB69dn6L3YghP8SEoYqTfOGks76XmvK68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717573695; c=relaxed/simple;
	bh=mKqA4leOhmqKlL21mGvcc2CfivHSZyriFSBctRQlj6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dmlrelj/4uzhHFRRKS/zhdIIIIWKOBHzIA4/7pUFRidp6E7cs4FJMmj0RjJ/Cj95fCAy30CbeglLQ8dj1xDKIEZ1TDeKN7VbFZ/LoWz4QwrschNVzRSNLa0N1+VAxiq1ya1+VAjix2LwkEAurxFxSIDII8R3eLmKSyfPHeutrZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=SBgvrLQf; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 76D79600A2;
	Wed,  5 Jun 2024 07:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1717573100;
	bh=mKqA4leOhmqKlL21mGvcc2CfivHSZyriFSBctRQlj6w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SBgvrLQf8axaNLuMqDgPY3sPId32/COBY8kYJj8p1+K8UaDPbPeJfaVDP1fwdBapq
	 s9HJcH+qogT41fhSLtFiEzPthkTPtaddLwSpxkTuRI8520VlrClYAr1TyT9d7PMNbU
	 j6DXsnQrRBkwtNZUTFsPdBsW5rSczmel7SQN4OW+ZqbVCZGJUohTz+l2VSXqInHj1j
	 u4I2VfvpRZu379Z0o9D3wI4hsp+0Ai2KWHSirJVumtgNHYnQSKHC97lBm0f1pagawv
	 pgHM4fF65PBvKIwBWSyxSJ2XHv16vfxOZKRneuliuv9ofbfr2NIozvxEXEuDuPfPoF
	 N0z/mbJo+llNQ==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 110612017EA;
	Wed, 05 Jun 2024 07:37:14 +0000 (UTC)
Message-ID: <d1e494b5-c537-4faa-8226-892718b736aa@fiberby.net>
Date: Wed, 5 Jun 2024 07:37:13 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 2/2] net/sched: cls_flower: add support for
 matching tunnel control flags
To: Davide Caratti <dcaratti@redhat.com>, i.maximets@ovn.org
Cc: davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com,
 jiri@resnulli.us, kuba@kernel.org, lucien.xin@gmail.com,
 marcelo.leitner@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com,
 xiyou.wangcong@gmail.com, echaudro@redhat.com,
 Simon Horman <horms@kernel.org>
References: <cover.1717088241.git.dcaratti@redhat.com>
 <bc5449dc17cfebe90849c9daba8a078065f5ddf8.1717088241.git.dcaratti@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <bc5449dc17cfebe90849c9daba8a078065f5ddf8.1717088241.git.dcaratti@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Davide and Ilva,

On 5/30/24 5:08 PM, Davide Caratti wrote:
> extend cls_flower to match TUNNEL_FLAGS_PRESENT bits in tunnel metadata.
> 
> Suggested-by: Ilya Maximets <i.maximets@ovn.org>
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> ---
>   include/uapi/linux/pkt_cls.h |  3 ++
>   net/sched/cls_flower.c       | 56 +++++++++++++++++++++++++++++++++++-
>   2 files changed, 58 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
> index 229fc925ec3a..b6d38f5fd7c0 100644
> --- a/include/uapi/linux/pkt_cls.h
> +++ b/include/uapi/linux/pkt_cls.h
> @@ -554,6 +554,9 @@ enum {
>   	TCA_FLOWER_KEY_SPI,		/* be32 */
>   	TCA_FLOWER_KEY_SPI_MASK,	/* be32 */
>   
> +	TCA_FLOWER_KEY_ENC_FLAGS,	/* u32 */
> +	TCA_FLOWER_KEY_ENC_FLAGS_MASK,	/* u32 */
> +
>   	__TCA_FLOWER_MAX,
>   };
>   
> diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
> index fd9a6f20b60b..eef570c577ac 100644
> --- a/net/sched/cls_flower.c
> +++ b/net/sched/cls_flower.c
> @@ -41,6 +41,12 @@
>   #define TCA_FLOWER_KEY_CT_FLAGS_MASK \
>   		(TCA_FLOWER_KEY_CT_FLAGS_MAX - 1)
>   
> +#define TUNNEL_FLAGS_PRESENT (\
> +	_BITUL(IP_TUNNEL_CSUM_BIT) |		\
> +	_BITUL(IP_TUNNEL_DONT_FRAGMENT_BIT) |	\
> +	_BITUL(IP_TUNNEL_OAM_BIT) |		\
> +	_BITUL(IP_TUNNEL_CRIT_OPT_BIT))
> +
>   struct fl_flow_key {
>   	struct flow_dissector_key_meta meta;
>   	struct flow_dissector_key_control control;
> @@ -75,6 +81,7 @@ struct fl_flow_key {
>   	struct flow_dissector_key_l2tpv3 l2tpv3;
>   	struct flow_dissector_key_ipsec ipsec;
>   	struct flow_dissector_key_cfm cfm;
> +	struct flow_dissector_key_enc_flags enc_flags;
>   } __aligned(BITS_PER_LONG / 8); /* Ensure that we can do comparisons as longs. */
>   
>   struct fl_flow_mask_range {
> @@ -732,6 +739,10 @@ static const struct nla_policy fl_policy[TCA_FLOWER_MAX + 1] = {
>   	[TCA_FLOWER_KEY_SPI_MASK]	= { .type = NLA_U32 },
>   	[TCA_FLOWER_L2_MISS]		= NLA_POLICY_MAX(NLA_U8, 1),
>   	[TCA_FLOWER_KEY_CFM]		= { .type = NLA_NESTED },
> +	[TCA_FLOWER_KEY_ENC_FLAGS]	= NLA_POLICY_MASK(NLA_U32,
> +							  TUNNEL_FLAGS_PRESENT),
> +`	[TCA_FLOWER_KEY_ENC_FLAGS_MASK]	= NLA_POLICY_MASK(NLA_U32,
> +							  TUNNEL_FLAGS_PRESENT),
>   };
>   
>   static const struct nla_policy
> @@ -1825,6 +1836,21 @@ static int fl_set_key_cfm(struct nlattr **tb,
>   	return 0;
>   }
>   
> +static int fl_set_key_enc_flags(struct nlattr **tb, u32 *flags_key,
> +				u32 *flags_mask, struct netlink_ext_ack *extack)
> +{
> +	/* mask is mandatory for flags */
> +	if (NL_REQ_ATTR_CHECK(extack, NULL, tb, TCA_FLOWER_KEY_ENC_FLAGS_MASK)) {
> +		NL_SET_ERR_MSG(extack, "missing enc_flags mask");
> +		return -EINVAL;
> +	}
> +
> +	*flags_key = nla_get_u32(tb[TCA_FLOWER_KEY_ENC_FLAGS]);
> +	*flags_mask = nla_get_u32(tb[TCA_FLOWER_KEY_ENC_FLAGS_MASK]);
> +
> +	return 0;
> +}
> +
>   static int fl_set_key(struct net *net, struct nlattr **tb,
>   		      struct fl_flow_key *key, struct fl_flow_key *mask,
>   		      struct netlink_ext_ack *extack)
> @@ -2059,9 +2085,16 @@ static int fl_set_key(struct net *net, struct nlattr **tb,
>   	if (ret)
>   		return ret;
>   
> -	if (tb[TCA_FLOWER_KEY_FLAGS])
> +	if (tb[TCA_FLOWER_KEY_FLAGS]) {
>   		ret = fl_set_key_flags(tb, &key->control.flags,
>   				       &mask->control.flags, extack);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (tb[TCA_FLOWER_KEY_ENC_FLAGS])
> +		ret = fl_set_key_enc_flags(tb, &key->enc_flags.flags,
> +					   &mask->enc_flags.flags, extack);
>   
>   	return ret;

Sorry, that I am late to the party, I have been away camping at
Electromagnetic Field in the UK.

Why not use the already existing key->enc_control.flags with dissector
key FLOW_DISSECTOR_KEY_ENC_CONTROL for storing the flags?

Currently key->enc_control.flags are unused.

I haven't fixed the drivers to validate that field yet, so currently
only sfc does so.

Look at include/uapi/linux/pkt_cls.h for netlink flags:

enum {
         TCA_FLOWER_KEY_FLAGS_IS_FRAGMENT = (1 << 0),
         TCA_FLOWER_KEY_FLAGS_FRAG_IS_FIRST = (1 << 1),
};

and at include/net/flow_dissector.h for the dissector flags:

#define FLOW_DIS_IS_FRAGMENT    BIT(0)
#define FLOW_DIS_FIRST_FRAG     BIT(1)
#define FLOW_DIS_ENCAPSULATION  BIT(2)

I would like to keep FLOW_DIS_ENCAPSULATION as the last flag, in order to
keep parity with the netlink flags, since the dissector flags field is
exposed to user space when some flags are not supported.

I realize that since this series is now merged, then fixing this up will
have to go in another series, are you up for that?

-- 
Best regards
Asbjørn Sloth Tønnesen
Network Engineer
Fiberby - AS42541

