Return-Path: <netdev+bounces-279225-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGbtLfOv4WkdwwAAu9opvQ
	(envelope-from <netdev+bounces-279225-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 05:58:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED70B416C1A
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 05:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A473300E712
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 03:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB9D34B1B4;
	Fri, 17 Apr 2026 03:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRjsrR4b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A4234A76A
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 03:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776398218; cv=pass; b=MrhQ4OYcs6JM8zVg1hy6IecFcRrYuLAwqbd6CJbE1CroN+ghisNpZhnDUzn/ngH3uuW2FLQ1TphYxWQ0sGG5Ew1by1ZNYliFthSF1j40BoYUhhyWh/JMeqY942VuzltfOHqp3anMX2cH65VrpfpHx+x5CTKh1wvqHUNLOahVef8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776398218; c=relaxed/simple;
	bh=zsGdmflO2f3lmanmgmceuyP/GFHaEYe7gl44qKE3nAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iyp621DJOO4gV36KGbnixsWEOtKKR9gxMIJFlB0yvGtmxT7YnmSr0uMt3QJKrmJxaFGJ1qgQScVpeJ7Svb026l7MN0Zi6YUfIOIcQsZ3/Vvm8/Sz0t2NtOJFHnXThorJQxu1giLOHEnf4voSwyq1Y25dCPhP6VGr3lVZyYwTAp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRjsrR4b; arc=pass smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8acb3daf2aaso3939166d6.0
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 20:56:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776398216; cv=none;
        d=google.com; s=arc-20240605;
        b=BaNKHf4sjFdVn7cHknZR2yOKYBkcLUqRQRvzAZebSsm7fmMrK5b3ScBWDan+Sm8l0p
         OsVaqjDFUc1T3XpeklQ71Edgv2Ci7cpNAm7FIW3gvblD0ugdYboXmM7fQ1VWyu1q6P0j
         hNh/3u3BZ93RBU/ghdrbDLBvHEIJqEzUHxxtLvSm2gPUMioVKpVme9LRHlsbP2W26BIi
         htm5zGqfRpTA2mDod5KaIZYgV+wy+6F067LCxUxREMQLMYv4Bg5AnbWAQ7azR3hta8kV
         xs46LUrdJ9Ryh6Wk6vCRgrX4TPlCZ1xZySGGeQKtU0U5dyVdaBRAucB3ZkS/MAKoT3ox
         c2pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CfX4BGWoC580FdN/KDbboWMf7un4Sw+ijW9qAykG0Xs=;
        fh=T5PRqdxAkQZZGjG3zzFkBrKsJhE95H47k4jyPm4y0tc=;
        b=E4VqxYZm3lcsUSdA7Mi4MZWpRPbrvZ07pRiSZIiwdx7Q2vqO4Urx2XPJPCplg5IPkN
         QZsfTgOipf4OJ7KD43KCnPfDXNoCkNjsNG/Hjs/1nDspqkO5M+UBLHVyr5hOzbCYPEX2
         e726ZIPNXKvDqk72d58YeWGIgqPBMPAfygZdc0kDXZb+WlQHqFwhBl4kKXQccj3TdACe
         XFLquirzFvzrnsd9vuaPTaM8y3PQcnapbzNvXoNM/YqKGrQTwtNToo28nJAC7nDPvg8p
         oboPw2XN2mwpDUPw63Y65t+SIDrH+ubHJk37xgk3P7j6P5rPmi2QzBGveTAXzaZo610m
         QS0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776398216; x=1777003016; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CfX4BGWoC580FdN/KDbboWMf7un4Sw+ijW9qAykG0Xs=;
        b=kRjsrR4bCfAHVuluRVbiNC1E1yaZzjJ4GtyhCIdqTq8cBnB3uF+UPq3P3okFA5FTzD
         OdEZ4SguloImob2mpwfdnYMxkfKcOKtWvSeKXQmXb7UTHP78KV+n9yReQsSwVLpYBiSF
         J1YZKsO6QBMft+nYZYn6fpV/oq4EAwZLbzgV5clcD3Hf4z50qdLvDDO1feQqVFVpCKAE
         lWp8wWctGS3w7P9kCfiUkAuGl29r8mr6yRA6igKj9/+LECQCQm4tNWPc8a95d0mQd9FT
         z3i1Z3ut3AlZOdVhQhQwLe0Ys5GshVu3AEkdk7ukgcHKNBI4rOGPxllrKu3DHq1/B4q7
         KZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776398216; x=1777003016;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CfX4BGWoC580FdN/KDbboWMf7un4Sw+ijW9qAykG0Xs=;
        b=dafIMd5LLSfoKvqlBHn8XwjCLlY9L1MS7Fo7zvcT2sNUEQXw0r4vODts7lKNeEozuD
         CQKKL6fmlPjccjQ4Dqwtd59v8tN0D+DrVCD3jTVOj5sAHV+NRpTZZIHyM0R697PboHQL
         mJtA/kCK+znDhiSbP2ngav4iGwIukHPUAI1aGwtbBiF6vZEmj/0XsZo/hGxQlJc21q4R
         aTrZWrlKW+krvKE1pYs5X+RqRldDQIKouHDgC7Vu5dkAmu5YuUPpQSE0xg4oodQnoxmI
         lbwZbS9pgathJOwMwV/NzlKIe3SUFwRKFJPsESMT4oMdwSeYyzG1zoluHswTefOll4mA
         oQMQ==
X-Gm-Message-State: AOJu0YythIUPKa9lEjYNLEvq9L+IUHZxz5qjf0EG0VngmmO1TpEd48V/
	yWc7eeom2P4GiinU5WXiGQaKKGYJ+q02QS4e9D4wMQN7WbrqvdbvWZz09Ha8JLxqTB6585aKBpa
	PdbjU2+zpVV0/PbnpqBlwku3YrcfcEGkttHgJ
X-Gm-Gg: AeBDievjG4cPVdZYq5fQDvqxs7MN0uzH5KwL+04ZHEFn3SztxY9xQl1ZgaMhKjyj1Dr
	bgt/AAE/GSjb5XSgFcSL4gU9kJeJ834A4LYaHc75KcbBuJUrhzaJa+8Ii5J5MBeFrKnOEAcZG7i
	obAmf8K2T/BQKdSgE2yPSgdyBblewjXuQ68pBaAq9GVHkJDtBWw5IMYzNJi/TWVKqty4dgCQ84z
	iFhdQKAI1TxDbFW3ZwRViD900j/4gR0igLTgn7HqtXL1ZThOj3N7P/vJeYnL5pL89f7PAvLG8cC
	nbeq59yhr6lT8jlFGeM=
X-Received: by 2002:a05:6214:3d0c:b0:89c:ed12:41b with SMTP id
 6a1803df08f44-8b028130413mr20567296d6.31.1776398216174; Thu, 16 Apr 2026
 20:56:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416130138.38050-1-phx0fer@gmail.com> <CAM0EoMmi0tdhB9ECmcpPea7iSFm5AiLme71cw5zXK+WVUZGEMw@mail.gmail.com>
In-Reply-To: <CAM0EoMmi0tdhB9ECmcpPea7iSFm5AiLme71cw5zXK+WVUZGEMw@mail.gmail.com>
From: phx <phx0fer@gmail.com>
Date: Fri, 17 Apr 2026 11:56:43 +0800
X-Gm-Features: AQROBzA9aFIFk554V3eIV1Bp_je2TnvIpZJunyJ3kLY6eXp_TriSEmJqTh3txDg
Message-ID: <CAKvCo-zzTSXJ6vTazSLD=G=SekH_f2=hOHVUogoq=CQeuovxZw@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: act_ct: fix skb leak on fragment check failure
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, horms@kernel.org
Content-Type: multipart/mixed; boundary="000000000000a7bc77064f9ff0ea"
X-Spamd-Result: default: False [-0.46 / 15.00];
	MIME_BAD_ATTACHMENT(1.60)[sh:text/x-sh];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,multipart/alternative,text/plain,text/x-sh];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279225-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~,4:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phx0fer@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ED70B416C1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000a7bc77064f9ff0ea
Content-Type: multipart/alternative; boundary="000000000000a7bc76064f9ff0e8"

--000000000000a7bc76064f9ff0e8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Found it through code review. Reproduced it on a 7.0-rc6 kernel
using a veth pair with act_ct on ingress:

  ip netns add ns_ct
  ip link add veth0 type veth peer name veth1
  ip link set veth1 netns ns_ct
  ip link set veth0 up
  ip netns exec ns_ct ip link set veth1 up
  tc qdisc add dev veth0 clsact
  tc filter add dev veth0 ingress protocol ip flower action ct zone 1

Then send truncated IP packets (10 bytes IP, need 20 minimum) from
the namespace via raw AF_PACKET socket on veth1. This hits
pskb_may_pull failure in tcf_ct_ipv4_is_fragment -> -EINVAL ->
out_frag -> TC_ACT_CONSUMED. net/core/dev.c handles TC_ACT_CONSUMED
by returning NULL without freeing the skb.

Result on unpatched kernel:
  Sent: 222 packets
  skbuff_head_cache: before=3D6439 after=3D6663 growth=3D224
  FAIL: skb leak detected (224 objects leaked)

Attached a test script that automates this. With the fix applied
(TC_ACT_SHOT for non-EINPROGRESS errors), the skbs get freed and
the test passes. The test script is generated by AI.

On Thu, Apr 16, 2026 at 11:32=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:

> On Thu, Apr 16, 2026 at 9:01=E2=80=AFAM Dudu Lu <phx0fer@gmail.com> wrote=
:
> >
> > When tcf_ct_handle_fragments() returns an error other than -EINPROGRESS
> > (e.g. -EINVAL from malformed fragments), tcf_ct_act() jumps to out_frag
> > which unconditionally returns TC_ACT_CONSUMED. This tells the caller th=
e
> > skb was consumed, but it was not freed, leaking one skb per malformed
> > fragment.
> >
> > TC_ACT_CONSUMED is only correct for -EINPROGRESS, where defragmentation
> > is genuinely in progress and the skb has been queued. For all other
> > errors the skb is still owned by the caller and must be freed via
> > TC_ACT_SHOT.
> >
> > Fixes: 3f14b377d01d ("net/sched: act_ct: fix skb leak and crash on ooo
> frags")
> > Signed-off-by: Dudu Lu <phx0fer@gmail.com>
>
> Do you have a reproducer? Always helps adding at least a tdc test.
> Also: How did you find this issue? was it AI? If yes, please add the
> tag "Assisted-by:<AI name here>"
>
> cheers,
> jamal
>
> > ---
> >  net/sched/act_ct.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
> > index 7d5e50c921a0..870655f682bd 100644
> > --- a/net/sched/act_ct.c
> > +++ b/net/sched/act_ct.c
> > @@ -1107,8 +1107,10 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff
> *skb, const struct tc_action *a,
> >         return retval;
> >
> >  out_frag:
> > -       if (err !=3D -EINPROGRESS)
> > +       if (err !=3D -EINPROGRESS) {
> >                 tcf_action_inc_drop_qstats(&c->common);
> > +               return TC_ACT_SHOT;
> > +       }
> >         return TC_ACT_CONSUMED;
> >
> >  drop:
> > --
> > 2.39.3 (Apple Git-145)
> >
>

--000000000000a7bc76064f9ff0e8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Found it through code review. Reproduced it on a 7.0-rc6 k=
ernel<br>using a veth pair with act_ct on ingress:<br><br>=C2=A0=C2=A0ip ne=
tns add ns_ct<br>=C2=A0=C2=A0ip link add veth0 type veth peer name veth1<br=
>=C2=A0=C2=A0ip link set veth1 netns ns_ct<br>=C2=A0=C2=A0ip link set veth0=
 up<br>=C2=A0=C2=A0ip netns exec ns_ct ip link set veth1 up<br>=C2=A0=C2=A0=
tc qdisc add dev veth0 clsact<br>=C2=A0=C2=A0tc filter add dev veth0 ingres=
s protocol ip flower action ct zone 1<br><br>Then send truncated IP packets=
 (10 bytes IP, need 20 minimum) from<br>the namespace via raw AF_PACKET soc=
ket on veth1. This hits<br>pskb_may_pull failure in tcf_ct_ipv4_is_fragment=
 -&gt; -EINVAL -&gt;<br>out_frag -&gt; TC_ACT_CONSUMED. net/core/dev.c hand=
les TC_ACT_CONSUMED<br>by returning NULL without freeing the skb.<br><br>Re=
sult on unpatched kernel:<br>=C2=A0=C2=A0Sent: 222 packets<br>=C2=A0=C2=A0s=
kbuff_head_cache: before=3D6439 after=3D6663 growth=3D224<br>=C2=A0=C2=A0FA=
IL: skb leak detected (224 objects leaked)<br><br>Attached a test script th=
at automates this. With the fix applied<br>(TC_ACT_SHOT for non-EINPROGRESS=
 errors), the skbs get freed and<br>the test passes. The test script is gen=
erated by AI.</div><br><div class=3D"gmail_quote gmail_quote_container"><di=
v dir=3D"ltr" class=3D"gmail_attr">On Thu, Apr 16, 2026 at 11:32=E2=80=AFPM=
 Jamal Hadi Salim &lt;<a href=3D"mailto:jhs@mojatatu.com">jhs@mojatatu.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">O=
n Thu, Apr 16, 2026 at 9:01=E2=80=AFAM Dudu Lu &lt;<a href=3D"mailto:phx0fe=
r@gmail.com" target=3D"_blank">phx0fer@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; When tcf_ct_handle_fragments() returns an error other than -EINPROGRES=
S<br>
&gt; (e.g. -EINVAL from malformed fragments), tcf_ct_act() jumps to out_fra=
g<br>
&gt; which unconditionally returns TC_ACT_CONSUMED. This tells the caller t=
he<br>
&gt; skb was consumed, but it was not freed, leaking one skb per malformed<=
br>
&gt; fragment.<br>
&gt;<br>
&gt; TC_ACT_CONSUMED is only correct for -EINPROGRESS, where defragmentatio=
n<br>
&gt; is genuinely in progress and the skb has been queued. For all other<br=
>
&gt; errors the skb is still owned by the caller and must be freed via<br>
&gt; TC_ACT_SHOT.<br>
&gt;<br>
&gt; Fixes: 3f14b377d01d (&quot;net/sched: act_ct: fix skb leak and crash o=
n ooo frags&quot;)<br>
&gt; Signed-off-by: Dudu Lu &lt;<a href=3D"mailto:phx0fer@gmail.com" target=
=3D"_blank">phx0fer@gmail.com</a>&gt;<br>
<br>
Do you have a reproducer? Always helps adding at least a tdc test.<br>
Also: How did you find this issue? was it AI? If yes, please add the<br>
tag &quot;Assisted-by:&lt;AI name here&gt;&quot;<br>
<br>
cheers,<br>
jamal<br>
<br>
&gt; ---<br>
&gt;=C2=A0 net/sched/act_ct.c | 4 +++-<br>
&gt;=C2=A0 1 file changed, 3 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c<br>
&gt; index 7d5e50c921a0..870655f682bd 100644<br>
&gt; --- a/net/sched/act_ct.c<br>
&gt; +++ b/net/sched/act_ct.c<br>
&gt; @@ -1107,8 +1107,10 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff=
 *skb, const struct tc_action *a,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return retval;<br>
&gt;<br>
&gt;=C2=A0 out_frag:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (err !=3D -EINPROGRESS)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (err !=3D -EINPROGRESS) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcf_actio=
n_inc_drop_qstats(&amp;c-&gt;common);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return TC_ACT_=
SHOT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return TC_ACT_CONSUMED;<br>
&gt;<br>
&gt;=C2=A0 drop:<br>
&gt; --<br>
&gt; 2.39.3 (Apple Git-145)<br>
&gt;<br>
</blockquote></div>

--000000000000a7bc76064f9ff0e8--
--000000000000a7bc77064f9ff0ea
Content-Type: text/x-sh; charset="UTF-8"; name="act_ct_skb_leak.sh"
Content-Disposition: attachment; filename="act_ct_skb_leak.sh"
Content-Transfer-Encoding: base64
Content-ID: <f_mo2dlc7s0>
X-Attachment-Id: f_mo2dlc7s0

IyEvYmluL2Jhc2gKIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMAojCiMgVGVzdCBm
b3Igc2tiIGxlYWsgaW4gYWN0X2N0IHdoZW4gdGNmX2N0X2hhbmRsZV9mcmFnbWVudHMoKSBmYWls
cy4KIwojIFdoZW4gYSB0cnVuY2F0ZWQgSVAgcGFja2V0IGhpdHMgYWN0X2N0LCB0Y2ZfY3RfaXB2
NF9pc19mcmFnbWVudCgpCiMgcmV0dXJucyAtRUlOVkFMLiBUaGUgb3V0X2ZyYWcgcGF0aCByZXR1
cm5zIFRDX0FDVF9DT05TVU1FRCwgYnV0IHRoZQojIHNrYiB3YXMgbmV2ZXIgYWN0dWFsbHkgY29u
c3VtZWQg4oCUIGl0IGxlYWtzLgojCiMgVGhpcyB0ZXN0IHNlbmRzIHRydW5jYXRlZCBJUCBwYWNr
ZXRzIHRocm91Z2ggYSB2ZXRoIHBhaXIgd2l0aCBhY3RfY3QKIyBvbiBpbmdyZXNzIGFuZCBjaGVj
a3Mgc2tidWZmX2hlYWRfY2FjaGUgc2xhYiBncm93dGguCgpzZXQgLWUKCnJlYWRvbmx5IE5TPSJu
cy1hY3QtY3QtbGVhay0kKG1rdGVtcCAtdSBYWFhYWFgpIgpyZWFkb25seSBERVY9InZldGgtY3Qw
IgpyZWFkb25seSBERVZfUEVFUj0idmV0aC1jdDEiCnJlYWRvbmx5IE5VTV9QS1RTPTUwMAojIE1p
bmltdW0gc2xhYiBncm93dGggdG8gY29uc2lkZXIgYSBsZWFrIChhbGxvdyBzb21lIG5vaXNlKQpy
ZWFkb25seSBMRUFLX1RIUkVTSE9MRD0yMDAKCmNsZWFudXAoKSB7CglpcCBsaW5rIGRlbCAkREVW
IDI+L2Rldi9udWxsIHx8IHRydWUKCWlwIG5ldG5zIGRlbCAkTlMgMj4vZGV2L251bGwgfHwgdHJ1
ZQp9Cgp0cmFwIGNsZWFudXAgRVhJVAoKZ2V0X3NrYl9hY3RpdmUoKSB7Cglhd2sgJy9za2J1ZmZf
aGVhZF9jYWNoZS8ge3ByaW50ICQyfScgL3Byb2Mvc2xhYmluZm8KfQoKIyBCdWlsZCB0aGUgcGFj
a2V0IHNlbmRlcgpidWlsZF9zZW5kZXIoKSB7Cglsb2NhbCBwcm9nPSIkMSIKCWxvY2FsIHNyYz0i
JHByb2cuYyIKCgljYXQgPiAiJHNyYyIgPDwgJ0VPRicKI2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNs
dWRlIDxzdHJpbmcuaD4KI2luY2x1ZGUgPHN0ZGxpYi5oPgojaW5jbHVkZSA8dW5pc3RkLmg+CiNp
bmNsdWRlIDxzeXMvc29ja2V0Lmg+CiNpbmNsdWRlIDxsaW51eC9pZl9wYWNrZXQuaD4KI2luY2x1
ZGUgPG5ldC9pZi5oPgojaW5jbHVkZSA8bmV0L2V0aGVybmV0Lmg+CiNpbmNsdWRlIDxhcnBhL2lu
ZXQuaD4KI2luY2x1ZGUgPGZjbnRsLmg+CgppbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3Yp
IHsKCWNvbnN0IGNoYXIgKmlmbmFtZSA9IGFyZ3ZbMV07CglpbnQgY291bnQgPSBhdG9pKGFyZ3Zb
Ml0pOwoJaW50IGZkLCBpLCBzZW50ID0gMDsKCglmZCA9IHNvY2tldChBRl9QQUNLRVQsIFNPQ0tf
UkFXLCBodG9ucyhFVEhfUF9BTEwpKTsKCWlmIChmZCA8IDApIHsgcGVycm9yKCJzb2NrZXQiKTsg
cmV0dXJuIDE7IH0KCWZjbnRsKGZkLCBGX1NFVEZMLCBPX05PTkJMT0NLKTsKCglzdHJ1Y3Qgc29j
a2FkZHJfbGwgc2EgPSB7fTsKCXNhLnNsbF9mYW1pbHkgPSBBRl9QQUNLRVQ7CglzYS5zbGxfcHJv
dG9jb2wgPSBodG9ucyhFVEhfUF9JUCk7CglzYS5zbGxfaWZpbmRleCA9IGlmX25hbWV0b2luZGV4
KGlmbmFtZSk7CglzYS5zbGxfaGFsZW4gPSA2OwoJbWVtc2V0KHNhLnNsbF9hZGRyLCAweGZmLCA2
KTsKCgkvKiBFdGhlcm5ldCgxNCkgKyB0cnVuY2F0ZWQgSVAoMTApID0gMjQgYnl0ZXMuCgkgKiBJ
UCBoZWFkZXIgbmVlZHMgMjAgYnl0ZXMgbWluaW11bSwgc28gcHNrYl9tYXlfcHVsbCBmYWlscwoJ
ICogaW4gdGNmX2N0X2lwdjRfaXNfZnJhZ21lbnQoKSAtPiAtRUlOVkFMLgoJICovCgl1bnNpZ25l
ZCBjaGFyIHBrdFsyNF0gPSB7fTsKCW1lbXNldChwa3QsIDB4ZmYsIDYpOwkJLyogZHN0ID0gYnJv
YWRjYXN0ICovCglwa3RbMTJdID0gMHgwODsgcGt0WzEzXSA9IDB4MDA7LyogZXRoZXJ0eXBlID0g
SVB2NCAqLwoJcGt0WzE0XSA9IDB4NDU7CQkJLyogdmVyPTQsIGlobD01ICovCglwa3RbMTZdID0g
MHgwMDsgcGt0WzE3XSA9IDB4MGE7LyogdG90YWxfbGVuPTEwICovCglwa3RbMjNdID0gMHgwNjsJ
CQkvKiBwcm90bz1UQ1AgKi8KCglmb3IgKGkgPSAwOyBpIDwgY291bnQ7IGkrKykgewoJCWlmIChz
ZW5kdG8oZmQsIHBrdCwgc2l6ZW9mKHBrdCksIDAsCgkJCSAgIChzdHJ1Y3Qgc29ja2FkZHIgKikm
c2EsIHNpemVvZihzYSkpID49IDApCgkJCXNlbnQrKzsKCX0KCXByaW50ZigiJWRcbiIsIHNlbnQp
OwoJY2xvc2UoZmQpOwoJcmV0dXJuIDA7Cn0KRU9GCglnY2MgLVdhbGwgLW8gIiRwcm9nIiAiJHNy
YyIKfQoKZWNobyAiPT09IGFjdF9jdCBza2IgbGVhayB0ZXN0ID09PSIKCiMgU2V0dXAgdmV0aCBw
YWlyIHdpdGggbmFtZXNwYWNlCmlwIG5ldG5zIGFkZCAkTlMKaXAgbGluayBhZGQgJERFViB0eXBl
IHZldGggcGVlciBuYW1lICRERVZfUEVFUgppcCBsaW5rIHNldCAkREVWX1BFRVIgbmV0bnMgJE5T
CmlwIGxpbmsgc2V0ICRERVYgdXAKaXAgbmV0bnMgZXhlYyAkTlMgaXAgbGluayBzZXQgJERFVl9Q
RUVSIHVwCgojIEFkZCBhY3RfY3QgZmlsdGVyIG9uIGluZ3Jlc3MKdGMgcWRpc2MgYWRkIGRldiAk
REVWIGNsc2FjdAp0YyBmaWx0ZXIgYWRkIGRldiAkREVWIGluZ3Jlc3MgcHJvdG9jb2wgaXAgZmxv
d2VyIGFjdGlvbiBjdCB6b25lIDEKCiMgQnVpbGQgc2VuZGVyClNFTkRFUj0kKG1rdGVtcCkKYnVp
bGRfc2VuZGVyICIkU0VOREVSIgoKIyBSZWNvcmQgc2xhYiBzdGF0ZQpCRUZPUkU9JChnZXRfc2ti
X2FjdGl2ZSkKCiMgU2VuZCB0cnVuY2F0ZWQgcGFja2V0cyBmcm9tIG5hbWVzcGFjZQpTRU5UPSQo
aXAgbmV0bnMgZXhlYyAkTlMgIiRTRU5ERVIiICRERVZfUEVFUiAkTlVNX1BLVFMpCnNsZWVwIDEK
CiMgUmVjb3JkIHNsYWIgc3RhdGUgYWdhaW4KQUZURVI9JChnZXRfc2tiX2FjdGl2ZSkKCiMgQ2hl
Y2sgdGMgc3RhdHMKRFJPUFBFRD0kKHRjIC1zIGZpbHRlciBzaG93IGRldiAkREVWIGluZ3Jlc3Mg
fCBcCgkgIGF3ayAnL2Ryb3BwZWQvIHtmb3IoaT0xO2k8PU5GO2krKykgaWYoJGk9PSJkcm9wcGVk
IikgcHJpbnQgJChpKzEpfScgfCBcCgkgIHRyIC1kICcsJykKCkdST1dUSD0kKChBRlRFUiAtIEJF
Rk9SRSkpCgplY2hvICJTZW50OiAkU0VOVCBwYWNrZXRzIgplY2hvICJUQyBkcm9wcGVkOiAkRFJP
UFBFRCIKZWNobyAic2tidWZmX2hlYWRfY2FjaGU6IGJlZm9yZT0kQkVGT1JFIGFmdGVyPSRBRlRF
UiBncm93dGg9JEdST1dUSCIKCnJtIC1mICIkU0VOREVSIiAiJHtTRU5ERVJ9LmMiCgppZiBbICIk
R1JPV1RIIiAtZ2UgIiRMRUFLX1RIUkVTSE9MRCIgXTsgdGhlbgoJZWNobyAiRkFJTDogc2tiIGxl
YWsgZGV0ZWN0ZWQgKCRHUk9XVEggb2JqZWN0cyBsZWFrZWQpIgoJZXhpdCAxCmVsc2UKCWVjaG8g
IlBBU1M6IG5vIHNpZ25pZmljYW50IHNrYiBsZWFrIgoJZXhpdCAwCmZpCg==
--000000000000a7bc77064f9ff0ea--

