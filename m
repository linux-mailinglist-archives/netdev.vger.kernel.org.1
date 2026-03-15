Return-Path: <netdev+bounces-267925-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIU3FODWtmkXJgEAu9opvQ
	(envelope-from <netdev+bounces-267925-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 16:57:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A618F2914F4
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 16:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFC7E302A694
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 15:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A03370D51;
	Sun, 15 Mar 2026 15:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="d0gtwYW3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7C9366546
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 15:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773590229; cv=pass; b=vE8hm/yOrxBi1XU01MR+FwLj+dQCYis5T5eWaOuRdFPNqRNzZE5k9UE6+JSJKlbhsAf6mjI5z0r9xKbOf0+PPMdRidGN4z5QvDJ3U7gcCnVir2Ok0zZVD+2UJI5f0LVJQLTuRSQYKzifnbQlTBwjxuR1R8Ve4Eqfur606jiFmKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773590229; c=relaxed/simple;
	bh=RHhZsLnqC6Bu6Ua4krxM/WIz6LxoxkyzOVR0OJNFQIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C70YhZbOrdzY+IbyPReiVHRLmytGgKDMZDLYm+OiYlKODN/lw+2QvLaWh1hyRQ87w7SRX9ca2hstJ05o0WQSLW9eGp5wgBMLGL+YsYE2lMyNItDckiqaUNDzCI0lrACFfILQV3r5Ev7XYwlNAmUsmeNFTmKiiM6Zstxkv/aLG0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=d0gtwYW3; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-829781b2b01so2361672b3a.2
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 08:57:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773590227; cv=none;
        d=google.com; s=arc-20240605;
        b=eu0gMQ1XweB6ksLgtEGbeLu1O7fp82yD7ZLqc42qkOR+tEPHt1ALMvIiL82BWRJ/iq
         PVwc4eHiWXECz8hDCdaT++qqebLPEUPfedwh8ZRHPVuzsxMI4XHSrwJzomDf2moChCaA
         n+/TLiOYcT7UHSPOe5golCPffhT0iatsqHELjOz1TZT3E7T1eH04GyDkvSyvjKOHQJF7
         RsI8Cf4x8iz2X8UE8ChKhox1Zy+hPlr4rtwnlLL+eyOz310RUYT3dAr+TiLsVcnCJBEF
         Vy4/bhWaBOvB6E4MERzpozwIMHKMWCP5Avyr++IcvXjtBkU4lW8tQ7gRyc96PgZWUVpk
         y+Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SKiLs1RyC55du9pBc4TcXHWFicF13Mvzo2PvrfgLqag=;
        fh=Mp2hs9P3BP/QKqpP8CsYi+NLBnHRzFu06/7QBJ/Qy/k=;
        b=TFSgf8VyzXpqOz2MjxYejRlEB5AFdLv9wogOxP35UPdl4MNGL/ae+7hN2o8ztbDoF7
         Z9mCXXy2Kf+AeNX5N18E79uJ3T9bsOjGR4c6xBD8MCO7XrV8Ac9dJKru9j62wTqCV9kP
         fMnuOmmDL/M2ty3sIqD7EOnIELCXFkCGVBPkStjV4x2LP/IRi60mMUjc+fNse1r5/TrQ
         OhJplsk2A4gym07H2+TLneRwSOCKSlhfE3zV4BTZBcy1JawHbqdCv9+23kCsH4ErSf/U
         uzIXCA9AMBVx+3G4lacXczTGVLFSGyfI+zXgZQYDrPUOfYx7yLxnyjg1o3I//h1hv4oZ
         ybJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1773590227; x=1774195027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKiLs1RyC55du9pBc4TcXHWFicF13Mvzo2PvrfgLqag=;
        b=d0gtwYW3LERaAfl6wkpYefFOaIeg1nSgHfprggMyM3QbUGnAC5WLE9Z5kbtQESzVXG
         rV7jvnUY5dBo4ah+vGNHlZz/vsPUYV7Hd/NSPpdoJNe6Hz5pRGViXAFCCa5akhv5VbIw
         zTftIm6K7DKwLPAOYuSm9MAOZX+Sa0Hv0wyCFxF4Zq7nbOzPywnShZbHsrFP5SyOp2Fd
         ClDIL74nCnAhXfQXTuFNhFO8/JNsgp7iizZbUHTyYGnIp2QKppEvGG7BaB3H4RQK8BPj
         3H3HyDCbujzY4I6NzysF2p7WmMpQ75++zTZzzshDr7xJ3HBRvHpXuCUC3ZcpBT+wK8QJ
         l3ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773590227; x=1774195027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SKiLs1RyC55du9pBc4TcXHWFicF13Mvzo2PvrfgLqag=;
        b=OE7mOwaltgjU71Y8cchhNpk3kFgfoLkyaoOiqpGDd9okCHxOwd7QMv6IBQknxbQ/TD
         bwId68zZKEUkbhYrijAJUVVXsWRzLhj8bv4Go6BcBLf38mJmlCT17WAhrEm6+nS6x4mR
         FMh0PFlhO5NXDkSnAZy74pcq516TV0VUw7lPyXbtzTkCrcv7R7cksjcL+USFMi3U734u
         Da9UZoeh9K2nLUTfGVAbzPVHnXqQS9fJQR8DWoP0+wf+IwuZ8Ikd8gHo2Cwy0pvB68DD
         8y/NKGZt45v8W8V8V4p3d/kS2vOuM9ilNGPRZfoFZ2AaZD52LvGnRC25CEUNb1h0E0mJ
         gPXg==
X-Gm-Message-State: AOJu0YyfAhdkKglO1wACXYK2cpeK+cs2S6nWNtJ6040EHC7i5T7gtgdt
	NEplvBhKqsWnoV4NEcujFlRffVNo1V6jKZ4H9U04o/ZlZCi6WI2TXcQ/5pXuTiDnLnBd/ygPaas
	M3fHujBOUMA1os14olYQKdu7pEa5s8QurmDz+3WNN
X-Gm-Gg: ATEYQzzHaJuyRsE8UaF7JVIflU9hCkxEilJ15Ql4gzrBsR1DOYG52LyNP3+r1AiL3eD
	gPsnuIHDImucHtPjMR3evwAdCpjv8I2xK2V1k2rc4zi3UtQftlUW1HhAUTJLawqWXlAvD458cir
	6o1AcDis/o/U5AoasbggA1UeMLlO5XSOEjHxx0EgL5vcDGwHsDe8RLPIdFDDjK381KaDgCdoALG
	VDHruVbtadO46QwNey6zzfsDBmE80X2QK6aOdA2ggcUuGF/W0hB4fa5IeorrDk3r3GNQZEdtOVf
	suxq3GnOHX488tM=
X-Received: by 2002:a05:6a00:854:b0:81e:81fb:b392 with SMTP id
 d2e1a72fcca58-82a196d9795mr9102209b3a.11.1773590227286; Sun, 15 Mar 2026
 08:57:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307212058.169511-1-jhs@mojatatu.com> <20260310184713.7e810431@kernel.org>
 <CAM0EoM=TAAfwZc3q1=RKWPrS778R_B8uM18ev_jYYz8oj4YiBA@mail.gmail.com>
 <20260311175249.54abe1b6@kernel.org> <CAM0EoMnv14pSaJWW3ZQuegkbQEqqye0zp0-_tCaOEWEg=C3xCQ@mail.gmail.com>
 <20260312165113.773a5f44@kernel.org> <CAM0EoMm0dMRKJyfCH80G=q4PnnTzzKVRvSrAU204FFKMn9NOtQ@mail.gmail.com>
 <CAM0EoM=KinOanha9nKJ=GyT2FU_o3Hg-tY5fWDfFO+PBuQfXpA@mail.gmail.com> <20260314080004.3e8575d8@kernel.org>
In-Reply-To: <20260314080004.3e8575d8@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 15 Mar 2026 11:56:56 -0400
X-Gm-Features: AaiRm51rmZBzVnloy_8xdC3vuhjPorclFaCvP3TTlZ3O1BeMklnatfJOc6SBkho
Message-ID: <CAM0EoMnY7b+wzxCP9Gqso-v7xBKjaA_9FN4OZc2YjifmCvAVsA@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: Mark qdisc for deletion if graft cannot delete
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, toke@toke.dk, 
	vinicius.gomes@intel.com, stephen@networkplumber.org, vladbu@nvidia.com, 
	cake@lists.bufferbloat.net, bpf@vger.kernel.org, ghandatmanas@gmail.com, 
	km.kim1503@gmail.com, security@kernel.org, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267925-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,resnulli.us,toke.dk,intel.com,networkplumber.org,nvidia.com,lists.bufferbloat.net,gmail.com,mojatatu.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A618F2914F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 14, 2026 at 11:00=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Fri, 13 Mar 2026 15:36:28 -0400 Jamal Hadi Salim wrote:
> > In this specific example, the issue is that the classifier code path
> > can't release the rtnl_lock while the qdisc's refcnt is bigger than 1.
> >
> > Does this make more sense?
> > The reason we went with the "mark for delete" approach is at time x+3
> > the "qdisc add" wont be able to find this qdisc. This is the common
> > observed pattern - for example described in the commit message where
> > we get have a slightly different flow with "qdisc del" before "filter
> > add".
>
> Maybe a (completely untested) diff will help illustrate my thinking
> better than words:
>

Dont have much time today - but will try in the upcoming days.

cheers,
jamal

> diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
> index 99ac747b7906..c13c9e8619e4 100644
> --- a/include/net/pkt_cls.h
> +++ b/include/net/pkt_cls.h
> @@ -27,6 +27,9 @@ void unregister_tcf_proto_ops(struct tcf_proto_ops *ops=
);
>  #define NET_CLS_ALIAS_PREFIX "net-cls-"
>  #define MODULE_ALIAS_NET_CLS(kind)     MODULE_ALIAS(NET_CLS_ALIAS_PREFIX=
 kind)
>
> +extern char *rtnl_load_mod;
> +void rtnl_load_mod_check(void);
> +
>  struct tcf_block_ext_info {
>         enum flow_block_binder_type binder_type;
>         tcf_chain_head_change_t *chain_head_change;
> diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> index 332fd9695e54..c21dd2e36592 100644
> --- a/net/sched/act_api.c
> +++ b/net/sched/act_api.c
> @@ -1368,11 +1368,15 @@ struct tc_action_ops *tc_action_load_ops(struct n=
lattr *nla, u32 flags,
>  #ifdef CONFIG_MODULES
>                 bool rtnl_held =3D !(flags & TCA_ACT_FLAGS_NO_RTNL);
>
> -               if (rtnl_held)
> -                       rtnl_unlock();
> +               if (rtnl_held) {
> +                       if (WARN_ON_ONCE(rtnl_load_mod))
> +                               return ERR_PTR(-EINVAL);
> +                       rtnl_load_mod =3D kasprintf(GFP_KERNEL,
> +                                                 NET_ACT_ALIAS_PREFIX "%=
s",
> +                                                 act_name);
> +                       return ERR_PTR(-EAGAIN);
> +               }
>                 request_module(NET_ACT_ALIAS_PREFIX "%s", act_name);
> -               if (rtnl_held)
> -                       rtnl_lock();
>
>                 a_o =3D tc_lookup_action_n(act_name);
>
> @@ -2107,6 +2111,9 @@ static int tcf_action_add(struct net *net, struct n=
lattr *nla,
>                                       &attr_size, flags, 0, extack);
>                 if (ret !=3D -EAGAIN)
>                         break;
> +               rtnl_unlock();
> +               rtnl_load_mod_check();
> +               rtnl_lock();
>         }
>
>         if (ret < 0)
> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index 4829c27446e3..1b0f762d6e4b 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -46,6 +46,19 @@
>  /* The list of all installed classifier types */
>  static LIST_HEAD(tcf_proto_base);
>
> +char *rtnl_load_mod;
> +
> +void rtnl_load_mod_check(void)
> +{
> +       char *mod =3D rtnl_load_mod;
> +
> +       if (mod) {
> +               rtnl_load_mod =3D NULL;
> +               request_module("%s", mod);
> +               kfree(mod);
> +       }
> +}
> +
>  /* Protects list of registered TC modules. It is pure SMP lock. */
>  static DEFINE_RWLOCK(cls_mod_lock);
>
> @@ -255,17 +268,15 @@ tcf_proto_lookup_ops(const char *kind, bool rtnl_he=
ld,
>         if (ops)
>                 return ops;
>  #ifdef CONFIG_MODULES
> -       if (rtnl_held)
> -               rtnl_unlock();
> +       if (rtnl_held) {
> +               if (WARN_ON_ONCE(rtnl_load_mod))
> +                       return ERR_PTR(-EINVAL);
> +               rtnl_load_mod =3D kasprintf(GFP_KERNEL,
> +                                         NET_CLS_ALIAS_PREFIX "%s", kind=
);
> +               return ERR_PTR(-EAGAIN);
> +       }
>         request_module(NET_CLS_ALIAS_PREFIX "%s", kind);
> -       if (rtnl_held)
> -               rtnl_lock();
>         ops =3D __tcf_proto_lookup_ops(kind);
> -       /* We dropped the RTNL semaphore in order to perform
> -        * the module load. So, even if we succeeded in loading
> -        * the module we have to replay the request. We indicate
> -        * this using -EAGAIN.
> -        */
>         if (ops) {
>                 module_put(ops->owner);
>                 return ERR_PTR(-EAGAIN);
> @@ -2459,6 +2470,7 @@ static int tc_new_tfilter(struct sk_buff *skb, stru=
ct nlmsghdr *n,
>                  * of target chain.
>                  */
>                 rtnl_held =3D true;
> +               rtnl_load_mod_check();
>                 /* Replay the request. */
>                 goto replay;
>         }
> @@ -3230,9 +3242,13 @@ static int tc_ctl_chain(struct sk_buff *skb, struc=
t nlmsghdr *n,
>         tcf_chain_put(chain);
>  errout_block:
>         tcf_block_release(q, block, true);
> -       if (err =3D=3D -EAGAIN)
> +       if (err =3D=3D -EAGAIN) {
> +               rtnl_unlock();
> +               rtnl_load_mod_check();
> +               rtnl_lock();
>                 /* Replay the request. */
>                 goto replay;
> +       }
>         return err;
>
>  errout_block_locked:

