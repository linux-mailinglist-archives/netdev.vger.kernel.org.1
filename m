Return-Path: <netdev+bounces-281151-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJ6kLLPx7Wn6pAAAu9opvQ
	(envelope-from <netdev+bounces-281151-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 13:06:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EBF469860
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 13:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9AAC73000884
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 11:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D680730146C;
	Sun, 26 Apr 2026 11:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="m7am0jYb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4306983A14
	for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 11:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777201580; cv=pass; b=hX/SRcpQE4scTbNEf86oU/Hdr7q1tsgVLHxtsBeNr1N2w/dK2Osd+1JqFAqHp1648eSS808cczjgV7feLQL1BbUeWZK/8HvtbG3/W6+/8EcS24bCEwf1MX+h5l/Bz73zKotWIx4bzwC9CX7xBWX2eP1+J4+q5KZjQVedxTcbreQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777201580; c=relaxed/simple;
	bh=sf7qoSlP01N8AuSkmq6HcQOlvb7Sd88t23kDLuDirZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SOANb3DaLQbKyL2nbtNOUq6xVVBCV0NZ46lwYj3lcTHjZwI7ds5JVqtT9ikUD6/tohN1Ft1Ar4NzABwsbCgr7wpk9Ri2FqHUlXIF6PrZ/2zBzroyAqGR9DSERsZdQCSjzi92Uj0/mp5DyVYzOS8eDcrPF326vSZTr2SRDAZyTQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=m7am0jYb; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82f2766905fso4282679b3a.3
        for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 04:06:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777201578; cv=none;
        d=google.com; s=arc-20240605;
        b=Izo0NuSHKMz1YeN93c3WxZqpFtjDvZJqij3TZGK5iow24sr6xk8RS2puWPZDFu8vGz
         RfP2CFxRoR/aWwZrlT3VVMF/vYA/noQGqEh62P/QX3qvIJa4jH5WpL9juO/hWbbqYA37
         kXcqzUKaqjdw85NkVOPlxKgWiBO6+XM1IwCEbiXrurjzYjiVZOaR1bYfe92IZfhpeMRz
         5BsoPbFvPEQ8TveJYZkGve14ISMDjsjwriPVlqttoURNkkIl4wvDC58APefPMZcyEq5B
         /ZWOtpsR12jPKnHDe0CYeIvk4HpdWH9WqQ+5GJwehLD7X+MlnwmTFRSq+Jgw+Q7S4cs1
         lZHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NnivsTrpkvDkzjpBT/eTV6LsIBVcfA5R8msWBmbAiQM=;
        fh=pA2h8hzNSRK5JaNmK0y8qZzhrX1OzoP4S2c1Um5rLe4=;
        b=aZw+XqAS7/PgSVxFTIcygyHFNh5sj7qohFWDMc4HQ5Yf5Z/Q5MZdnjRzWjwu2zQbDO
         Uu36IEahPVei10wpq98ISHA1QJra953Xrrm3EaAMhbbIq3XmNNharM3Z8mvuljaoDF7Q
         r7xENaarD/Y1DIQ9RJ0J8b4N0J/cjC36GHZmwqVcJRFKD3XaAeNr5kdTvqcGea0P/pfw
         sm1ACytN3vdOCSv5csMyNj7/IBw4faD8SAVbk4vF7zVxJCiNR56qPvdE11y0DwLYpZ0F
         Pi8BaaAq2b1Za3CdwLP4NJhLDzsPz7XIHCqW7nsNtmDqwerEGgL7llu3kSe2BDD7Pc6p
         P3Xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1777201578; x=1777806378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnivsTrpkvDkzjpBT/eTV6LsIBVcfA5R8msWBmbAiQM=;
        b=m7am0jYb72usV6va3QNII6Cd5FAN7mBNuCzxKNrBA0yaQSKn4kOez6P04BczfTPuH8
         4gnjn9L3MNczbS5xosp3RPAYsBXdmDY/IEFoU83GtiFagaMaBeXaf6e/yuRFv2Y46hJz
         srD5jimLK+DbgoPQeGh5VfyNNbbpUsLVuoK32axY8k5Q1i/R0jULpS1buaZQNSJ4XwyO
         yCuPBNDGR56LiQ9MVYnr7fu4+t+lrXd8jU9UiaWKIi9Bk68NUhHhcNJtHZIOEhl75l6I
         wVPRro1YcFF+kUvLG1IFRbXtwq7Pvv5W5VHGlAIifG+2xQfoTivF8y+EVyDRv44pUHsF
         KRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777201578; x=1777806378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NnivsTrpkvDkzjpBT/eTV6LsIBVcfA5R8msWBmbAiQM=;
        b=ccTprF4aDlYu8HjFGgF0BFzEvl26ZKnw4NOndvXsi2HqKdqPgDD8ldBh24v276XKJJ
         cyl4MG0FY/XbTHAy4AyLMHXj3pKQQlAYIX4YX9Z2nn3RpaQu58t15ZB782+sK0h7Z+0c
         H6rKbYgI1WHkz3z80M/oK4OdHtnVRrjZl3/It/k9F9VTBGUgX1Cr70ULf2g6IoGJV1sZ
         YFD22bnLRB+XSzkqmGAqfIlMx9G72kjtZodb18fl2yEfHQgFEL08StpkGC4dCaxJ5+7N
         7jBJqR+/7X99Rp2ctKAnQzA8whXzj8M0e3dBjfY9AZd3pcwml49jXWGI7HvJEHPBuq5O
         xlwQ==
X-Gm-Message-State: AOJu0YxJ+91nF3eKi2DIZpvYYe5S8EGQh7uYFUdvfvfVTopg1LBgUAmH
	rQ8sMhC6XdaRv6fnyh1s9Sxb0QEaoevWA5qQopO3FdXp3Yi4u+oDXRC1CpekgBay8LgTAvQAEvC
	+nMJfNp8mnrZtrNsH1R7weaHT8VZP4biM1rexoAxWaYdt8edTH34=
X-Gm-Gg: AeBDieuaVhg57itDOCNQy1dAscS8Ru3WCDXFzU+CI0ruv0vURAf0vFB7CtAMss8BtK0
	fS7maGTHFtJ0uaBGa0lypbQyZwK8zhhPFpSTu1WbvJPXDDI0xrz4ZoYB3QrxI/cjYYG/zNLVp9K
	jH6InzsIdv0XmSYuERK5nX2isL4Gdxkvf/9JX+sOiVd3kUtENUBX5bLR4t4K832Gds8x3HV2FPf
	5X3MijxB3fC50Z2Uepg5g2m0qT1yJeDzpkuO0uQ7oVXcyobAS7npRIiRvPkglswdmLWVkcTZkLt
	wkigzGLce1UG0MCttGkSsMJzVglBfA==
X-Received: by 2002:a05:6a00:a15:b0:829:8942:2ca4 with SMTP id
 d2e1a72fcca58-82f8c838f04mr43144993b3a.19.1777201578572; Sun, 26 Apr 2026
 04:06:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416130138.38050-1-phx0fer@gmail.com> <CAM0EoMmi0tdhB9ECmcpPea7iSFm5AiLme71cw5zXK+WVUZGEMw@mail.gmail.com>
 <CAKvCo-zzTSXJ6vTazSLD=G=SekH_f2=hOHVUogoq=CQeuovxZw@mail.gmail.com>
In-Reply-To: <CAKvCo-zzTSXJ6vTazSLD=G=SekH_f2=hOHVUogoq=CQeuovxZw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 26 Apr 2026 07:06:06 -0400
X-Gm-Features: AQROBzCDXrsvGqPQbKOWYsw0IrsjmtfzOzOhve-sPnkhb93eHNY7gSq4yx10I-s
Message-ID: <CAM0EoM=NAEr9Ars_HxC0CeS=VwF_fV0_mrU4_y48C12dgv+qwQ@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: act_ct: fix skb leak on fragment check failure
To: phx <phx0fer@gmail.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A5EBF469860
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	TAGGED_FROM(0.00)[bounces-281151-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]

On Thu, Apr 16, 2026 at 11:56=E2=80=AFPM phx <phx0fer@gmail.com> wrote:
>
> Found it through code review. Reproduced it on a 7.0-rc6 kernel
> using a veth pair with act_ct on ingress:
>
>   ip netns add ns_ct
>   ip link add veth0 type veth peer name veth1
>   ip link set veth1 netns ns_ct
>   ip link set veth0 up
>   ip netns exec ns_ct ip link set veth1 up
>   tc qdisc add dev veth0 clsact
>   tc filter add dev veth0 ingress protocol ip flower action ct zone 1
>

Please create a test case using tdc as a second patch. And look at
what Sashiko is complaining about and address it if it makes sense...

cheers,
jamal
> Then send truncated IP packets (10 bytes IP, need 20 minimum) from
> the namespace via raw AF_PACKET socket on veth1. This hits
> pskb_may_pull failure in tcf_ct_ipv4_is_fragment -> -EINVAL ->
> out_frag -> TC_ACT_CONSUMED. net/core/dev.c handles TC_ACT_CONSUMED
> by returning NULL without freeing the skb.
>
> Result on unpatched kernel:
>   Sent: 222 packets
>   skbuff_head_cache: before=3D6439 after=3D6663 growth=3D224
>   FAIL: skb leak detected (224 objects leaked)
>
> Attached a test script that automates this. With the fix applied
> (TC_ACT_SHOT for non-EINPROGRESS errors), the skbs get freed and
> the test passes. The test script is generated by AI.
>
> On Thu, Apr 16, 2026 at 11:32=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.c=
om> wrote:
>>
>> On Thu, Apr 16, 2026 at 9:01=E2=80=AFAM Dudu Lu <phx0fer@gmail.com> wrot=
e:
>> >
>> > When tcf_ct_handle_fragments() returns an error other than -EINPROGRES=
S
>> > (e.g. -EINVAL from malformed fragments), tcf_ct_act() jumps to out_fra=
g
>> > which unconditionally returns TC_ACT_CONSUMED. This tells the caller t=
he
>> > skb was consumed, but it was not freed, leaking one skb per malformed
>> > fragment.
>> >
>> > TC_ACT_CONSUMED is only correct for -EINPROGRESS, where defragmentatio=
n
>> > is genuinely in progress and the skb has been queued. For all other
>> > errors the skb is still owned by the caller and must be freed via
>> > TC_ACT_SHOT.
>> >
>> > Fixes: 3f14b377d01d ("net/sched: act_ct: fix skb leak and crash on ooo=
 frags")
>> > Signed-off-by: Dudu Lu <phx0fer@gmail.com>
>>
>> Do you have a reproducer? Always helps adding at least a tdc test.
>> Also: How did you find this issue? was it AI? If yes, please add the
>> tag "Assisted-by:<AI name here>"
>>
>> cheers,
>> jamal
>>
>> > ---
>> >  net/sched/act_ct.c | 4 +++-
>> >  1 file changed, 3 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
>> > index 7d5e50c921a0..870655f682bd 100644
>> > --- a/net/sched/act_ct.c
>> > +++ b/net/sched/act_ct.c
>> > @@ -1107,8 +1107,10 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff=
 *skb, const struct tc_action *a,
>> >         return retval;
>> >
>> >  out_frag:
>> > -       if (err !=3D -EINPROGRESS)
>> > +       if (err !=3D -EINPROGRESS) {
>> >                 tcf_action_inc_drop_qstats(&c->common);
>> > +               return TC_ACT_SHOT;
>> > +       }
>> >         return TC_ACT_CONSUMED;
>> >
>> >  drop:
>> > --
>> > 2.39.3 (Apple Git-145)
>> >

