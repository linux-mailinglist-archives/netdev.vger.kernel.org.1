Return-Path: <netdev+bounces-272583-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJkyBPWOxmlLLwUAu9opvQ
	(envelope-from <netdev+bounces-272583-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 15:06:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D36345C00
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 15:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E29D310EBF0
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 13:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875193EFD0B;
	Fri, 27 Mar 2026 13:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="pvL8rdi5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A453EF0CF
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 13:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774619903; cv=pass; b=bQ09xboRQrNenHCWXEbZDAr66zz91ea5cIaPFuclnoylda5M4ePctcGM844/MuOiy3akgPPWIz3DmR02lsoHg2k996/o6cH39A+19XDDXSpMv+ku7SN4Pegp7B5q1O9qx/0+ct3FJ7kBhifDuxXg/3Pxooj49qhO9o6rsaX1q+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774619903; c=relaxed/simple;
	bh=QzA74K1Hhvoz5ZCmdv5xsdY3Q3i9wVbULLLV5Th/q+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KQZFNstt0kNFRLO6IF/RBp+NTWyZD9He/gyIlG0rgJWkeQbFm1hKttX1F/Ubebvn/y7XFt3GY/0MSZjhNBxe+Ow9IaNAgdTNlL5UEya13mbfsGdAU0l2OuLa6cxkJGDWc7GCURYFEbJUjsxaH0xgjQPNPd+8DX+OfAAK5CEiMak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=pvL8rdi5; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64eb84d1e37so1830282d50.2
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 06:58:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774619901; cv=none;
        d=google.com; s=arc-20240605;
        b=EExX1ZSbPQZdYlFSjiZJNp5K70QETyv6Cv54VbonNY8V0tGRz6BFy6Ttz3H05mj/Ge
         NL7kH6ti5zkv+SOqr4LsvClpOsMl5+ZPyI/nt8LbQJ5ReXhpDnhGcX5YhxsH/JLjyGDP
         sW5cnnx3Dmt8iMYNSi7RX/ycTBaSuEkih+KLGVKzp/YAyWuqOG8nPbd4ij9cGv5b+eq+
         N5U4EmRI04Q0TE+8cblojf+02q5B7r+IM1gXA0SQk9G12E5hLbY2cKcQgpeX/tC7AJ79
         C9zvMIkZDwnZPE8sM/ToY+ygVFIIRbZsQQk2REuVyWx/NKCKzqte/xWm2CjCIpqjpZCi
         xjDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pUo2IQFe+f/MujS6VFh95qsNE99wNjDHaJmpmU3TV2o=;
        fh=Mp2hs9P3BP/QKqpP8CsYi+NLBnHRzFu06/7QBJ/Qy/k=;
        b=WU/reYQnNAnl97zc5zAjqRsZiKv6Qe474K05Ak2bv1b8ulRqH5pH/G45oAf4SaPnjM
         otesKmiKPC4zop8FC+TuTI8cg782X35LbPRHvPlCsxqIaSl2N+gtWR3bWfbWz6b6tCEq
         /u7+ZrUT3nKIWXxW1SYDvrKRUyDTLQblstQ9Z7lE+6tSAB3u3ilHHdM/jVuiMLCPpQ/s
         ygSK279BHjbppr4rNAZrGx77ArivYA/T5seWN/1s5wQcLpALPfRm4M4oVREs24g2iZbk
         fNLsleb50B+QDqDogctxaeI8yw6LRmjP9R89af9TFV1bXTBYomSHHDDPlEdEXv5n7Wxo
         9A9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1774619901; x=1775224701; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pUo2IQFe+f/MujS6VFh95qsNE99wNjDHaJmpmU3TV2o=;
        b=pvL8rdi5vL68X0KRwoqTkjM3J0RDw0Lhzs0O4K+QJXWqODheMNxJ/6X3aYdEgUftSV
         kLaD+CPxFPMHxvY81YcLY7V2BVdYMxd30QJHVyIjM+AL4Q2+o7jm51CNjpAj576blR4Q
         8h2ZuU8qvB34pg/ZT8AthE/p/3AAr8UEJNn/AZDhKo5hQXkNsznssQkbWfd+5zDSyiju
         PYR5TCFncIMWc8HFjJS0oa9ZITcXMLx27eGDov+OBPIEA+RDco1p4TvmtbUEAH/WUCXQ
         13i/QoN8QU1YLyYzyx4MZoPJtPhqKIg3dHANPidRfjHJ5gqd01UDZhxi3a91l5hnOnBh
         Kcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774619901; x=1775224701;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUo2IQFe+f/MujS6VFh95qsNE99wNjDHaJmpmU3TV2o=;
        b=iGY5SS1dBi0ycJlAtjYR4b/GCU8Sl4hk/AEPo1itYU6L5eU0uPyrzy52f39n7mjAju
         NOdqjY2q7nAD8sTZxa61Ud9k70Ra1EJLsS8a+XOou7cRgLQW8sXchyMAKPAuIcvotOwn
         ecapUPxaH9i6KNjpi1WU141KmHIs/b4gYueVcC9K9SflLMy97JA3+o+yx3RWhOXEmCvg
         hw9iTbprjrk+jBEhG33oAE/3FhPeVV7wpm44WJmqYsDXtSc3NnXqOh90TCsDlvdMzq1q
         F6np7AoS+8U6ULxo0i6F1/uhzs8QlH4k/s/Cxzc4pRGhKK/lvJxFv8TJEPAx0l7gv8Ey
         +hZw==
X-Gm-Message-State: AOJu0YzLyBYz5nmv9pR3p6Yn5wOXi3CmiPOArG5UyPxBy5TxKee5mTvl
	3qqk8WvnVPt3jAVOsWOQiTpe0yDBmBuLC0MrfEeaCFYN1f6z6aC78i+B2ncWykf3eiFiCLtFoeL
	TPtbJKpAOm2/RpP+E+1rYQiTnmOOVNxqQS3eVtD2N
X-Gm-Gg: ATEYQzzyI1mcEI95vkHBC1NkwN0oxYzHquVOiKgq6Y8DjuqhGQIz/5zMN4ys5q3xZI5
	sWmveojBze2R9CI0v2rvtkpGUHA6zTouIaprxhGaDdhgIGWyhVXv5SHtRFF/e8vFveUE7ci5Ojq
	e4fRwSKZi/mno3vcMV64I3SGaYdcEmKkV36rZy35iC2zzqDaCmM4S0omH23rXXe5WbOIUDi8zrN
	JQ4cqxa8RD6eFzVsNhntm+l99uUU/2odka+gIUNmyKgJXzmX1xg3MzcKEaOZbc3zkgr8kc7jTt4
	HsR5KbTO0WHdun3SkC0=
X-Received: by 2002:a05:690c:e4ed:b0:798:78fd:fed8 with SMTP id
 00721157ae682-79bde02da76mr22406907b3.33.1774619900373; Fri, 27 Mar 2026
 06:58:20 -0700 (PDT)
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
 <CAM0EoM=KinOanha9nKJ=GyT2FU_o3Hg-tY5fWDfFO+PBuQfXpA@mail.gmail.com>
 <20260314080004.3e8575d8@kernel.org> <CAM0EoMnY7b+wzxCP9Gqso-v7xBKjaA_9FN4OZc2YjifmCvAVsA@mail.gmail.com>
In-Reply-To: <CAM0EoMnY7b+wzxCP9Gqso-v7xBKjaA_9FN4OZc2YjifmCvAVsA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 27 Mar 2026 09:58:07 -0400
X-Gm-Features: AQROBzDrrPdi990AGAg6-F0M0OF5N4NAsjLwSdwbFH-zTceO6WslvkHOrccP0Mc
Message-ID: <CAM0EoMnh2HyeSNvJDUsO1orriXncM4XSRqLyco6wMF3=mqcsSw@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: Mark qdisc for deletion if graft cannot delete
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, toke@toke.dk, 
	vinicius.gomes@intel.com, stephen@networkplumber.org, vladbu@nvidia.com, 
	cake@lists.bufferbloat.net, bpf@vger.kernel.org, ghandatmanas@gmail.com, 
	km.kim1503@gmail.com, security@kernel.org, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: multipart/mixed; boundary="000000000000c66a7c064e01e491"
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-272583-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,resnulli.us,toke.dk,intel.com,networkplumber.org,nvidia.com,lists.bufferbloat.net,gmail.com,mojatatu.com];
	HAS_ATTACHMENT(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,mojatatu.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 66D36345C00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000c66a7c064e01e491
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 15, 2026 at 11:56=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> On Sat, Mar 14, 2026 at 11:00=E2=80=AFAM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> >
> > On Fri, 13 Mar 2026 15:36:28 -0400 Jamal Hadi Salim wrote:
> > > In this specific example, the issue is that the classifier code path
> > > can't release the rtnl_lock while the qdisc's refcnt is bigger than 1=
.
> > >
> > > Does this make more sense?
> > > The reason we went with the "mark for delete" approach is at time x+3
> > > the "qdisc add" wont be able to find this qdisc. This is the common
> > > observed pattern - for example described in the commit message where
> > > we get have a slightly different flow with "qdisc del" before "filter
> > > add".
> >
> > Maybe a (completely untested) diff will help illustrate my thinking
> > better than words:
> >
>
> Dont have much time today - but will try in the upcoming days.
>

Sorry - was a bit loaded with work. So finally tried this idea - see
attached. Comments:

The bigger challenge is when we encounter a phony action (one that
does not exist). This gets exacerbated when you have a list of actions
and the phony one is in the middle.
 One attempt to resolve this involves keeping the transaction state of
the last failed action loading; see the variable rtnl_failed_act_num
(another global variable).

The global variables leave a stench (and we should not even consider
such an approach), but this seems resolvable by returning back a
"retry context".

tbh, I am not sure about this approach; while we can make it work, we
are adding unnecessary complexity to an already complex piece of code.

cheers,
jamal

> cheers,
> jamal
>
> > diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
> > index 99ac747b7906..c13c9e8619e4 100644
> > --- a/include/net/pkt_cls.h
> > +++ b/include/net/pkt_cls.h
> > @@ -27,6 +27,9 @@ void unregister_tcf_proto_ops(struct tcf_proto_ops *o=
ps);
> >  #define NET_CLS_ALIAS_PREFIX "net-cls-"
> >  #define MODULE_ALIAS_NET_CLS(kind)     MODULE_ALIAS(NET_CLS_ALIAS_PREF=
IX kind)
> >
> > +extern char *rtnl_load_mod;
> > +void rtnl_load_mod_check(void);
> > +
> >  struct tcf_block_ext_info {
> >         enum flow_block_binder_type binder_type;
> >         tcf_chain_head_change_t *chain_head_change;
> > diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> > index 332fd9695e54..c21dd2e36592 100644
> > --- a/net/sched/act_api.c
> > +++ b/net/sched/act_api.c
> > @@ -1368,11 +1368,15 @@ struct tc_action_ops *tc_action_load_ops(struct=
 nlattr *nla, u32 flags,
> >  #ifdef CONFIG_MODULES
> >                 bool rtnl_held =3D !(flags & TCA_ACT_FLAGS_NO_RTNL);
> >
> > -               if (rtnl_held)
> > -                       rtnl_unlock();
> > +               if (rtnl_held) {
> > +                       if (WARN_ON_ONCE(rtnl_load_mod))
> > +                               return ERR_PTR(-EINVAL);
> > +                       rtnl_load_mod =3D kasprintf(GFP_KERNEL,
> > +                                                 NET_ACT_ALIAS_PREFIX =
"%s",
> > +                                                 act_name);
> > +                       return ERR_PTR(-EAGAIN);
> > +               }
> >                 request_module(NET_ACT_ALIAS_PREFIX "%s", act_name);
> > -               if (rtnl_held)
> > -                       rtnl_lock();
> >
> >                 a_o =3D tc_lookup_action_n(act_name);
> >
> > @@ -2107,6 +2111,9 @@ static int tcf_action_add(struct net *net, struct=
 nlattr *nla,
> >                                       &attr_size, flags, 0, extack);
> >                 if (ret !=3D -EAGAIN)
> >                         break;
> > +               rtnl_unlock();
> > +               rtnl_load_mod_check();
> > +               rtnl_lock();
> >         }
> >
> >         if (ret < 0)
> > diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> > index 4829c27446e3..1b0f762d6e4b 100644
> > --- a/net/sched/cls_api.c
> > +++ b/net/sched/cls_api.c
> > @@ -46,6 +46,19 @@
> >  /* The list of all installed classifier types */
> >  static LIST_HEAD(tcf_proto_base);
> >
> > +char *rtnl_load_mod;
> > +
> > +void rtnl_load_mod_check(void)
> > +{
> > +       char *mod =3D rtnl_load_mod;
> > +
> > +       if (mod) {
> > +               rtnl_load_mod =3D NULL;
> > +               request_module("%s", mod);
> > +               kfree(mod);
> > +       }
> > +}
> > +
> >  /* Protects list of registered TC modules. It is pure SMP lock. */
> >  static DEFINE_RWLOCK(cls_mod_lock);
> >
> > @@ -255,17 +268,15 @@ tcf_proto_lookup_ops(const char *kind, bool rtnl_=
held,
> >         if (ops)
> >                 return ops;
> >  #ifdef CONFIG_MODULES
> > -       if (rtnl_held)
> > -               rtnl_unlock();
> > +       if (rtnl_held) {
> > +               if (WARN_ON_ONCE(rtnl_load_mod))
> > +                       return ERR_PTR(-EINVAL);
> > +               rtnl_load_mod =3D kasprintf(GFP_KERNEL,
> > +                                         NET_CLS_ALIAS_PREFIX "%s", ki=
nd);
> > +               return ERR_PTR(-EAGAIN);
> > +       }
> >         request_module(NET_CLS_ALIAS_PREFIX "%s", kind);
> > -       if (rtnl_held)
> > -               rtnl_lock();
> >         ops =3D __tcf_proto_lookup_ops(kind);
> > -       /* We dropped the RTNL semaphore in order to perform
> > -        * the module load. So, even if we succeeded in loading
> > -        * the module we have to replay the request. We indicate
> > -        * this using -EAGAIN.
> > -        */
> >         if (ops) {
> >                 module_put(ops->owner);
> >                 return ERR_PTR(-EAGAIN);
> > @@ -2459,6 +2470,7 @@ static int tc_new_tfilter(struct sk_buff *skb, st=
ruct nlmsghdr *n,
> >                  * of target chain.
> >                  */
> >                 rtnl_held =3D true;
> > +               rtnl_load_mod_check();
> >                 /* Replay the request. */
> >                 goto replay;
> >         }
> > @@ -3230,9 +3242,13 @@ static int tc_ctl_chain(struct sk_buff *skb, str=
uct nlmsghdr *n,
> >         tcf_chain_put(chain);
> >  errout_block:
> >         tcf_block_release(q, block, true);
> > -       if (err =3D=3D -EAGAIN)
> > +       if (err =3D=3D -EAGAIN) {
> > +               rtnl_unlock();
> > +               rtnl_load_mod_check();
> > +               rtnl_lock();
> >                 /* Replay the request. */
> >                 goto replay;
> > +       }
> >         return err;
> >
> >  errout_block_locked:

--000000000000c66a7c064e01e491
Content-Type: application/octet-stream; name=p2
Content-Disposition: attachment; filename=p2
Content-Transfer-Encoding: base64
Content-ID: <f_mn8ysiop0>
X-Attachment-Id: f_mn8ysiop0

ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbmV0L2FjdF9hcGkuaCBiL2luY2x1ZGUvbmV0L2FjdF9hcGku
aAppbmRleCBkMTFiNzkxMDc5MzAuLjdlMmQxNTFhZGRmZSAxMDA2NDQKLS0tIGEvaW5jbHVkZS9u
ZXQvYWN0X2FwaS5oCisrKyBiL2luY2x1ZGUvbmV0L2FjdF9hcGkuaApAQCAtMjE3LDYgKzIxNyw3
IEBAIGludCB0Y2ZfYWN0aW9uX2luaXQoc3RydWN0IG5ldCAqbmV0LCBzdHJ1Y3QgdGNmX3Byb3Rv
ICp0cCwgc3RydWN0IG5sYXR0ciAqbmxhLAogCQkgICAgc3RydWN0IHRjX2FjdGlvbiAqYWN0aW9u
c1tdLCBpbnQgaW5pdF9yZXNbXSwgc2l6ZV90ICphdHRyX3NpemUsCiAJCSAgICB1MzIgZmxhZ3Ms
IHUzMiBmbF9mbGFncywgc3RydWN0IG5ldGxpbmtfZXh0X2FjayAqZXh0YWNrKTsKIHN0cnVjdCB0
Y19hY3Rpb25fb3BzICp0Y19hY3Rpb25fbG9hZF9vcHMoc3RydWN0IG5sYXR0ciAqbmxhLCB1MzIg
ZmxhZ3MsCisJCQkJCSBpbnQgYWN0X251bSwKIAkJCQkJIHN0cnVjdCBuZXRsaW5rX2V4dF9hY2sg
KmV4dGFjayk7CiBzdHJ1Y3QgdGNfYWN0aW9uICp0Y2ZfYWN0aW9uX2luaXRfMShzdHJ1Y3QgbmV0
ICpuZXQsIHN0cnVjdCB0Y2ZfcHJvdG8gKnRwLAogCQkJCSAgICBzdHJ1Y3QgbmxhdHRyICpubGEs
IHN0cnVjdCBubGF0dHIgKmVzdCwKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbmV0L3BrdF9jbHMuaCBi
L2luY2x1ZGUvbmV0L3BrdF9jbHMuaAppbmRleCA5OWFjNzQ3Yjc5MDYuLmU4ZTcyMmE5ZTUzOCAx
MDA2NDQKLS0tIGEvaW5jbHVkZS9uZXQvcGt0X2Nscy5oCisrKyBiL2luY2x1ZGUvbmV0L3BrdF9j
bHMuaApAQCAtMjcsNiArMjcsOSBAQCB2b2lkIHVucmVnaXN0ZXJfdGNmX3Byb3RvX29wcyhzdHJ1
Y3QgdGNmX3Byb3RvX29wcyAqb3BzKTsKICNkZWZpbmUgTkVUX0NMU19BTElBU19QUkVGSVggIm5l
dC1jbHMtIgogI2RlZmluZSBNT0RVTEVfQUxJQVNfTkVUX0NMUyhraW5kKQlNT0RVTEVfQUxJQVMo
TkVUX0NMU19BTElBU19QUkVGSVgga2luZCkKIAorZXh0ZXJuIGNoYXIgKnJ0bmxfbG9hZF9tb2Q7
CitleHRlcm4gaW50IHJ0bmxfZmFpbGVkX2FjdF9udW07CisKIHN0cnVjdCB0Y2ZfYmxvY2tfZXh0
X2luZm8gewogCWVudW0gZmxvd19ibG9ja19iaW5kZXJfdHlwZSBiaW5kZXJfdHlwZTsKIAl0Y2Zf
Y2hhaW5faGVhZF9jaGFuZ2VfdCAqY2hhaW5faGVhZF9jaGFuZ2U7CmRpZmYgLS1naXQgYS9uZXQv
c2NoZWQvYWN0X2FwaS5jIGIvbmV0L3NjaGVkL2FjdF9hcGkuYwppbmRleCAzMzJmZDk2OTVlNTQu
LjQwYzM1MGM4Y2UxZCAxMDA2NDQKLS0tIGEvbmV0L3NjaGVkL2FjdF9hcGkuYworKysgYi9uZXQv
c2NoZWQvYWN0X2FwaS5jCkBAIC0xMzMyLDcgKzEzMzIsNyBAQCB2b2lkIHRjZl9pZHJfaW5zZXJ0
X21hbnkoc3RydWN0IHRjX2FjdGlvbiAqYWN0aW9uc1tdLCBpbnQgaW5pdF9yZXNbXSkKIH0KIAog
c3RydWN0IHRjX2FjdGlvbl9vcHMgKnRjX2FjdGlvbl9sb2FkX29wcyhzdHJ1Y3QgbmxhdHRyICpu
bGEsIHUzMiBmbGFncywKLQkJCQkJIHN0cnVjdCBuZXRsaW5rX2V4dF9hY2sgKmV4dGFjaykKKwkJ
CQkJIGludCBhY3RfbnVtLCBzdHJ1Y3QgbmV0bGlua19leHRfYWNrICpleHRhY2spCiB7CiAJYm9v
bCBwb2xpY2UgPSBmbGFncyAmIFRDQV9BQ1RfRkxBR1NfUE9MSUNFOwogCXN0cnVjdCBubGF0dHIg
KnRiW1RDQV9BQ1RfTUFYICsgMV07CkBAIC0xMzY3LDkgKzEzNjcsMzkgQEAgc3RydWN0IHRjX2Fj
dGlvbl9vcHMgKnRjX2FjdGlvbl9sb2FkX29wcyhzdHJ1Y3QgbmxhdHRyICpubGEsIHUzMiBmbGFn
cywKIAlpZiAoYV9vID09IE5VTEwpIHsKICNpZmRlZiBDT05GSUdfTU9EVUxFUwogCQlib29sIHJ0
bmxfaGVsZCA9ICEoZmxhZ3MgJiBUQ0FfQUNUX0ZMQUdTX05PX1JUTkwpOworCQlib29sIGJpbmQg
PSBmbGFncyAmIFRDQV9BQ1RfRkxBR1NfQklORDsKIAotCQlpZiAocnRubF9oZWxkKQorCQlpZiAo
cnRubF9oZWxkKSB7CisJCQkvKiBiaW5kIG1lYW5zIHdlIGFyZSBjb21pbmcgaW4gZnJvbSBhIGNv
ZGUgcGF0aCB3aGljaAorCQkJICogaGFzIGEgZmlsdGVyIHJlZmVyaW5nIHRvIGFuIGFjdGlvbiAo
Y2xzX2FwaSkKKwkJCSAqLworCQkJaWYgKGJpbmQpIHsKKwkJCQkvKiBXZSBhbHJlYWR5IHRyaWVk
IHRvIGxvYWQgdGhlIGFjdGlvbiBtb2R1bGUKKwkJCQkgKiBpbiBhIHByZXZpb3VzIGNhbGwgZnJv
bSBjbHNfYXBpIGJ1dCBldmVuCisJCQkJICogdGhpcyBzdWJzZXF1ZW50IGNhbGwgKHRjX2xvb2t1
cF9hY3Rpb25fbikKKwkJCQkgKiBmYWlsZWQgdG8gZmluZCB0aGUgYWN0aW9uCisJCQkJICogcnRu
bF9mYWlsZWRfYWN0X251bSB3aWxsIGNhdGNoIHRoaXMgaXNzdWUKKwkJCQkgKiBvZiBzdWJzZXF1
ZW50IGZhaWx1cmVzLi4uCisJCQkJICovCisJCQkJaWYgKHJ0bmxfZmFpbGVkX2FjdF9udW0gJiYK
KwkJCQkgICAgcnRubF9mYWlsZWRfYWN0X251bSA+PSBhY3RfbnVtKSB7CisJCQkJCWtmcmVlKHJ0
bmxfbG9hZF9tb2QpOworCQkJCQlydG5sX2xvYWRfbW9kID0gTlVMTDsKKwkJCQkJcnRubF9mYWls
ZWRfYWN0X251bSA9IDA7CisJCQkJCWdvdG8gYWN0X25vdF9mb3VuZDsKKwkJCQl9CisJCQkJcnRu
bF9sb2FkX21vZCA9IGthc3ByaW50ZihHRlBfS0VSTkVMLAorCQkJCQkJCSAgTkVUX0FDVF9BTElB
U19QUkVGSVggIiVzIiwKKwkJCQkJCQkgIGFjdF9uYW1lKTsKKwkJCQlpZiAoIXJ0bmxfbG9hZF9t
b2QpIHsKKwkJCQkJcnRubF9mYWlsZWRfYWN0X251bSA9IDA7CisJCQkJCXJldHVybiBFUlJfUFRS
KC1FTk9NRU0pOworCQkJCX0KKwkJCQlydG5sX2ZhaWxlZF9hY3RfbnVtID0gYWN0X251bTsKKwkJ
CQlyZXR1cm4gRVJSX1BUUigtRUFHQUlOKTsKKwkJCX0KIAkJCXJ0bmxfdW5sb2NrKCk7CisJCX0K
IAkJcmVxdWVzdF9tb2R1bGUoTkVUX0FDVF9BTElBU19QUkVGSVggIiVzIiwgYWN0X25hbWUpOwog
CQlpZiAocnRubF9oZWxkKQogCQkJcnRubF9sb2NrKCk7CkBAIC0xMzg3LDYgKzE0MTcsNyBAQCBz
dHJ1Y3QgdGNfYWN0aW9uX29wcyAqdGNfYWN0aW9uX2xvYWRfb3BzKHN0cnVjdCBubGF0dHIgKm5s
YSwgdTMyIGZsYWdzLAogCQkJcmV0dXJuIEVSUl9QVFIoLUVBR0FJTik7CiAJCX0KICNlbmRpZgor
YWN0X25vdF9mb3VuZDoKIAkJTkxfU0VUX0VSUl9NU0coZXh0YWNrLCAiRmFpbGVkIHRvIGxvYWQg
VEMgYWN0aW9uIG1vZHVsZSIpOwogCQlyZXR1cm4gRVJSX1BUUigtRU5PRU5UKTsKIAl9CkBAIC0x
NDk2LDcgKzE1MjcsNyBAQCBpbnQgdGNmX2FjdGlvbl9pbml0KHN0cnVjdCBuZXQgKm5ldCwgc3Ry
dWN0IHRjZl9wcm90byAqdHAsIHN0cnVjdCBubGF0dHIgKm5sYSwKIAlmb3IgKGkgPSAxOyBpIDw9
IFRDQV9BQ1RfTUFYX1BSSU8gJiYgdGJbaV07IGkrKykgewogCQlzdHJ1Y3QgdGNfYWN0aW9uX29w
cyAqYV9vOwogCi0JCWFfbyA9IHRjX2FjdGlvbl9sb2FkX29wcyh0YltpXSwgZmxhZ3MsIGV4dGFj
ayk7CisJCWFfbyA9IHRjX2FjdGlvbl9sb2FkX29wcyh0YltpXSwgZmxhZ3MsIGksIGV4dGFjayk7
CiAJCWlmIChJU19FUlIoYV9vKSkgewogCQkJZXJyID0gUFRSX0VSUihhX28pOwogCQkJZ290byBl
cnJfbW9kOwpkaWZmIC0tZ2l0IGEvbmV0L3NjaGVkL2Nsc19hcGkuYyBiL25ldC9zY2hlZC9jbHNf
YXBpLmMKaW5kZXggNDgyOWMyNzQ0NmUzLi4zNGJmZTlhNjNlZGEgMTAwNjQ0Ci0tLSBhL25ldC9z
Y2hlZC9jbHNfYXBpLmMKKysrIGIvbmV0L3NjaGVkL2Nsc19hcGkuYwpAQCAtNDYsNiArNDYsOSBA
QAogLyogVGhlIGxpc3Qgb2YgYWxsIGluc3RhbGxlZCBjbGFzc2lmaWVyIHR5cGVzICovCiBzdGF0
aWMgTElTVF9IRUFEKHRjZl9wcm90b19iYXNlKTsKIAorY2hhciAqcnRubF9sb2FkX21vZDsKK2lu
dCBydG5sX2ZhaWxlZF9hY3RfbnVtOworCiAvKiBQcm90ZWN0cyBsaXN0IG9mIHJlZ2lzdGVyZWQg
VEMgbW9kdWxlcy4gSXQgaXMgcHVyZSBTTVAgbG9jay4gKi8KIHN0YXRpYyBERUZJTkVfUldMT0NL
KGNsc19tb2RfbG9jayk7CiAKQEAgLTM0OSw3ICszNTIsNyBAQCBzdGF0aWMgYm9vbCB0Y2ZfcHJv
dG9fY2hlY2tfa2luZChzdHJ1Y3QgbmxhdHRyICpraW5kLCBjaGFyICpuYW1lKQogCXJldHVybiBm
YWxzZTsKIH0KIAotc3RhdGljIGJvb2wgdGNmX3Byb3RvX2lzX3VubG9ja2VkKGNvbnN0IGNoYXIg
KmtpbmQpCitzdGF0aWMgYm9vbCB0Y2ZfcHJvdG9faXNfdW5sb2NrZWQoY29uc3QgY2hhciAqa2lu
ZCwgYm9vbCBydG5sX2hlbGQpCiB7CiAJY29uc3Qgc3RydWN0IHRjZl9wcm90b19vcHMgKm9wczsK
IAlib29sIHJldDsKQEAgLTM1Nyw3ICszNjAsNyBAQCBzdGF0aWMgYm9vbCB0Y2ZfcHJvdG9faXNf
dW5sb2NrZWQoY29uc3QgY2hhciAqa2luZCkKIAlpZiAoc3RybGVuKGtpbmQpID09IDApCiAJCXJl
dHVybiBmYWxzZTsKIAotCW9wcyA9IHRjZl9wcm90b19sb29rdXBfb3BzKGtpbmQsIGZhbHNlLCBO
VUxMKTsKKwlvcHMgPSB0Y2ZfcHJvdG9fbG9va3VwX29wcyhraW5kLCBydG5sX2hlbGQsIE5VTEwp
OwogCS8qIE9uIGVycm9yIHJldHVybiBmYWxzZSB0byB0YWtlIHJ0bmwgbG9jay4gUHJvdG8gbG9v
a3VwL2NyZWF0ZQogCSAqIGZ1bmN0aW9ucyB3aWxsIHBlcmZvcm0gbG9va3VwIGFnYWluIGFuZCBw
cm9wZXJseSBoYW5kbGUgZXJyb3JzLgogCSAqLwpAQCAtMjIyOCw2ICsyMjMxLDEyIEBAIHN0YXRp
YyBib29sIGlzX3FkaXNjX2luZ3Jlc3MoX191MzIgY2xhc3NpZCkKIAlyZXR1cm4gKFRDX0hfTUlO
KGNsYXNzaWQpID09IFRDX0hfTUlOKFRDX0hfTUlOX0lOR1JFU1MpKTsKIH0KIAorc3RhdGljIGJv
b2wgcGFyZW50X2lzX2luZ3Jlc3Nfb3JfZWdyZXNzKF9fdTMyIHBhcmVudGlkKQoreworCXJldHVy
biAoVENfSF9NQUtFKFRDX0hfQ0xTQUNULCBUQ19IX01JTl9JTkdSRVNTKSA9PSBwYXJlbnRpZCkg
fHwKKwkJKFRDX0hfTUFLRShUQ19IX0NMU0FDVCwgVENfSF9NSU5fRUdSRVNTKSA9PSBwYXJlbnRp
ZCk7Cit9CisKIHN0YXRpYyBib29sIGlzX2luZ3Jlc3Nfb3JfY2xzYWN0KHN0cnVjdCB0Y2ZfYmxv
Y2sgKmJsb2NrLCBzdHJ1Y3QgUWRpc2MgKnEpCiB7CiAJcmV0dXJuIHRjZl9ibG9ja19zaGFyZWQo
YmxvY2spIHx8IChxICYmICEhKHEtPmZsYWdzICYgVENRX0ZfSU5HUkVTUykpOwpAQCAtMjI1NSw2
ICsyMjY0LDcgQEAgc3RhdGljIGludCB0Y19uZXdfdGZpbHRlcihzdHJ1Y3Qgc2tfYnVmZiAqc2ti
LCBzdHJ1Y3Qgbmxtc2doZHIgKm4sCiAJaW50IGVycjsKIAlpbnQgdHBfY3JlYXRlZDsKIAlib29s
IHJ0bmxfaGVsZCA9IGZhbHNlOworCWJvb2wgcHJvdG9faXNfdW5sb2NrZWQ7CiAJdTMyIGZsYWdz
OwogCiByZXBsYXk6CkBAIC0yMjkwLDI1ICsyMzAwLDMwIEBAIHN0YXRpYyBpbnQgdGNfbmV3X3Rm
aWx0ZXIoc3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0IG5sbXNnaGRyICpuLAogCQl9CiAJfQog
Ci0JLyogRmluZCBoZWFkIG9mIGZpbHRlciBjaGFpbi4gKi8KLQotCWVyciA9IF9fdGNmX3FkaXNj
X2ZpbmQobmV0LCAmcSwgJnBhcmVudCwgdC0+dGNtX2lmaW5kZXgsIGZhbHNlLCBleHRhY2spOwot
CWlmIChlcnIpCi0JCXJldHVybiBlcnI7Ci0KIAlpZiAodGNmX3Byb3RvX2NoZWNrX2tpbmQodGNh
W1RDQV9LSU5EXSwgbmFtZSkpIHsKIAkJTkxfU0VUX0VSUl9NU0coZXh0YWNrLCAiU3BlY2lmaWVk
IFRDIGZpbHRlciBuYW1lIHRvbyBsb25nIik7Ci0JCWVyciA9IC1FSU5WQUw7Ci0JCWdvdG8gZXJy
b3V0OworCQlyZXR1cm4gLUVJTlZBTDsKIAl9CisJcHJvdG9faXNfdW5sb2NrZWQgPSB0Y2ZfcHJv
dG9faXNfdW5sb2NrZWQobmFtZSwgcnRubF9oZWxkKTsKIAotCS8qIFRha2UgcnRubCBtdXRleCBp
ZiBydG5sX2hlbGQgd2FzIHNldCB0byB0cnVlIG9uIHByZXZpb3VzIGl0ZXJhdGlvbiwKLQkgKiBi
bG9jayBpcyBzaGFyZWQgKG5vIHFkaXNjIGZvdW5kKSwgcWRpc2MgaXMgbm90IHVubG9ja2VkLCBj
bGFzc2lmaWVyCi0JICogdHlwZSBpcyBub3Qgc3BlY2lmaWVkLCBjbGFzc2lmaWVyIGlzIG5vdCB1
bmxvY2tlZC4KLQkgKi8KLQlpZiAocnRubF9oZWxkIHx8Ci0JICAgIChxICYmICEocS0+b3BzLT5j
bF9vcHMtPmZsYWdzICYgUURJU0NfQ0xBU1NfT1BTX0RPSVRfVU5MT0NLRUQpKSB8fAotCSAgICAh
dGNmX3Byb3RvX2lzX3VubG9ja2VkKG5hbWUpKSB7CisJaWYgKCFydG5sX2hlbGQgJiYgIXBhcmVu
dF9pc19pbmdyZXNzX29yX2VncmVzcyhwYXJlbnQpKSB7CisJCXJ0bmxfaGVsZCA9IHRydWU7CisJ
CXJ0bmxfbG9jaygpOworCX0KKworCS8qIEZpbmQgaGVhZCBvZiBmaWx0ZXIgY2hhaW4uICovCisJ
ZXJyID0gX190Y2ZfcWRpc2NfZmluZChuZXQsICZxLCAmcGFyZW50LCB0LT50Y21faWZpbmRleCwg
cnRubF9oZWxkLAorCQkJICAgICAgIGV4dGFjayk7CisJaWYgKGVycikgeworCQlpZiAocnRubF9o
ZWxkKQorCQkJZ290byBlcnJvdXQ7CisJCXJldHVybiBlcnI7CisJfQorCisgICAgICAgLyogVGFr
ZSBydG5sIG11dGV4IGlmIGNsYXNzaWZpZXIgdHlwZSBpcyBub3Qgc3BlY2lmaWVkLCBvciBjbGFz
c2lmaWVyCisJKiBpcyBub3QgdW5sb2NrZWQuCisJKi8KKwlpZiAoIXJ0bmxfaGVsZCAmJiAhcHJv
dG9faXNfdW5sb2NrZWQpIHsKIAkJcnRubF9oZWxkID0gdHJ1ZTsKIAkJcnRubF9sb2NrKCk7CiAJ
fQpAQCAtMjQ1MSwxNyArMjQ2Niw0MyBAQCBzdGF0aWMgaW50IHRjX25ld190ZmlsdGVyKHN0cnVj
dCBza19idWZmICpza2IsIHN0cnVjdCBubG1zZ2hkciAqbiwKIAl9CiAJdGNmX2Jsb2NrX3JlbGVh
c2UocSwgYmxvY2ssIHJ0bmxfaGVsZCk7CiAKLQlpZiAocnRubF9oZWxkKQotCQlydG5sX3VubG9j
aygpOwotCiAJaWYgKGVyciA9PSAtRUFHQUlOKSB7CiAJCS8qIFRha2UgcnRubCBsb2NrIGluIGNh
c2UgRUFHQUlOIGlzIGNhdXNlZCBieSBjb25jdXJyZW50IGZsdXNoCiAJCSAqIG9mIHRhcmdldCBj
aGFpbi4KIAkJICovCi0JCXJ0bmxfaGVsZCA9IHRydWU7CisJCWlmIChydG5sX2hlbGQpIHsKKwkJ
CWlmIChydG5sX2xvYWRfbW9kKSB7CisJCQkJaW50IGZhaWxlZF9hY3RfbnVtID0gcnRubF9mYWls
ZWRfYWN0X251bTsKKwkJCQljaGFyIG1vZFtNT0RVTEVfTkFNRV9MRU5dOworCisJCQkJLyogU2F2
aW5nIHRoZXNlIHZhcmlhYmxlcyBzbyB0aGV5IGRvbnQgZ2V0IGxvc3QKKwkJCQkgKiB3aGVuIHJ0
bmwgbG9jayBpcyByZWxlYXNlZAorCQkJCSAqLworCQkJCXN0cnNjcHkobW9kLCBydG5sX2xvYWRf
bW9kKTsKKwkJCQlrZnJlZShydG5sX2xvYWRfbW9kKTsKKwkJCQlydG5sX2xvYWRfbW9kID0gTlVM
TDsKKwkJCQlydG5sX2ZhaWxlZF9hY3RfbnVtID0gMDsKKworCQkJCXJ0bmxfdW5sb2NrKCk7CisJ
CQkJcmVxdWVzdF9tb2R1bGUoIiVzIiwgbW9kKTsKKwkJCQlydG5sX2xvY2soKTsKKwkJCQlydG5s
X2ZhaWxlZF9hY3RfbnVtID0gZmFpbGVkX2FjdF9udW07CisJCQl9CisJCX0gZWxzZSB7CisJCQly
dG5sX2xvY2soKTsKKwkJCXJ0bmxfaGVsZCA9IHRydWU7CisJCX0KIAkJLyogUmVwbGF5IHRoZSBy
ZXF1ZXN0LiAqLwogCQlnb3RvIHJlcGxheTsKIAl9CisKKwlpZiAocnRubF9oZWxkKSB7CisJCWtm
cmVlKHJ0bmxfbG9hZF9tb2QpOworCQlydG5sX2xvYWRfbW9kID0gTlVMTDsKKwkJcnRubF9mYWls
ZWRfYWN0X251bSA9IDA7CisJCXJ0bmxfdW5sb2NrKCk7CisJfQorCiAJcmV0dXJuIGVycjsKIAog
ZXJyb3V0X2xvY2tlZDoKQEAgLTI0ODgsNiArMjUyOSw3IEBAIHN0YXRpYyBpbnQgdGNfZGVsX3Rm
aWx0ZXIoc3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0IG5sbXNnaGRyICpuLAogCXVuc2lnbmVk
IGxvbmcgY2wgPSAwOwogCXZvaWQgKmZoID0gTlVMTDsKIAlpbnQgZXJyOworCWJvb2wgcHJvdG9f
aXNfdW5sb2NrZWQgPSB0cnVlOwogCWJvb2wgcnRubF9oZWxkID0gZmFsc2U7CiAKIAllcnIgPSBu
bG1zZ19wYXJzZV9kZXByZWNhdGVkKG4sIHNpemVvZigqdCksIHRjYSwgVENBX01BWCwKQEAgLTI1
MDUsMjQgKzI1NDcsMjkgQEAgc3RhdGljIGludCB0Y19kZWxfdGZpbHRlcihzdHJ1Y3Qgc2tfYnVm
ZiAqc2tiLCBzdHJ1Y3Qgbmxtc2doZHIgKm4sCiAJCXJldHVybiAtRU5PRU5UOwogCX0KIAotCS8q
IEZpbmQgaGVhZCBvZiBmaWx0ZXIgY2hhaW4uICovCi0KLQllcnIgPSBfX3RjZl9xZGlzY19maW5k
KG5ldCwgJnEsICZwYXJlbnQsIHQtPnRjbV9pZmluZGV4LCBmYWxzZSwgZXh0YWNrKTsKLQlpZiAo
ZXJyKQotCQlyZXR1cm4gZXJyOwotCiAJaWYgKHRjZl9wcm90b19jaGVja19raW5kKHRjYVtUQ0Ff
S0lORF0sIG5hbWUpKSB7CiAJCU5MX1NFVF9FUlJfTVNHKGV4dGFjaywgIlNwZWNpZmllZCBUQyBm
aWx0ZXIgbmFtZSB0b28gbG9uZyIpOwotCQllcnIgPSAtRUlOVkFMOwotCQlnb3RvIGVycm91dDsK
KwkJcmV0dXJuIC1FSU5WQUw7CiAJfQotCS8qIFRha2UgcnRubCBtdXRleCBpZiBmbHVzaGluZyB3
aG9sZSBjaGFpbiwgYmxvY2sgaXMgc2hhcmVkIChubyBxZGlzYwotCSAqIGZvdW5kKSwgcWRpc2Mg
aXMgbm90IHVubG9ja2VkLCBjbGFzc2lmaWVyIHR5cGUgaXMgbm90IHNwZWNpZmllZCwKLQkgKiBj
bGFzc2lmaWVyIGlzIG5vdCB1bmxvY2tlZC4KKwlwcm90b19pc191bmxvY2tlZCA9IHRjZl9wcm90
b19pc191bmxvY2tlZChuYW1lLCBydG5sX2hlbGQpOworCisJaWYgKCFwYXJlbnRfaXNfaW5ncmVz
c19vcl9lZ3Jlc3MocGFyZW50KSkgeworCQlydG5sX2hlbGQgPSB0cnVlOworCQlydG5sX2xvY2so
KTsKKwl9CisKKwkvKiBGaW5kIGhlYWQgb2YgZmlsdGVyIGNoYWluLiAqLworCWVyciA9IF9fdGNm
X3FkaXNjX2ZpbmQobmV0LCAmcSwgJnBhcmVudCwgdC0+dGNtX2lmaW5kZXgsIHJ0bmxfaGVsZCwK
KwkJCSAgICAgICBleHRhY2spOworCWlmIChlcnIpIHsKKwkJaWYgKHJ0bmxfaGVsZCkKKwkJCXJ0
bmxfdW5sb2NrKCk7CisJCXJldHVybiBlcnI7CisJfQorCS8qIFRha2UgcnRubCBtdXRleCBpZiBm
bHVzaGluZyB3aG9sZSBjaGFpbiwgY2xhc3NpZmllciB0eXBlIGlzIG5vdAorCSAqIHNwZWNpZmll
ZCwgY2xhc3NpZmllciBpcyBub3QgdW5sb2NrZWQuCiAJICovCi0JaWYgKCFwcmlvIHx8Ci0JICAg
IChxICYmICEocS0+b3BzLT5jbF9vcHMtPmZsYWdzICYgUURJU0NfQ0xBU1NfT1BTX0RPSVRfVU5M
T0NLRUQpKSB8fAotCSAgICAhdGNmX3Byb3RvX2lzX3VubG9ja2VkKG5hbWUpKSB7CisJaWYgKCFy
dG5sX2hlbGQgJiYgKCFwcmlvIHx8ICFwcm90b19pc191bmxvY2tlZCkpIHsKIAkJcnRubF9oZWxk
ID0gdHJ1ZTsKIAkJcnRubF9sb2NrKCk7CiAJfQpAQCAtMjY0OCw2ICsyNjk1LDcgQEAgc3RhdGlj
IGludCB0Y19nZXRfdGZpbHRlcihzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3Qgbmxtc2doZHIg
Km4sCiAJdm9pZCAqZmggPSBOVUxMOwogCWludCBlcnI7CiAJYm9vbCBydG5sX2hlbGQgPSBmYWxz
ZTsKKwlib29sIHByb3RvX2lzX3VubG9ja2VkOwogCiAJZXJyID0gbmxtc2dfcGFyc2VfZGVwcmVj
YXRlZChuLCBzaXplb2YoKnQpLCB0Y2EsIFRDQV9NQVgsCiAJCQkJICAgICBydG1fdGNhX3BvbGlj
eSwgZXh0YWNrKTsKQEAgLTI2NjQsMjMgKzI3MTIsMjkgQEAgc3RhdGljIGludCB0Y19nZXRfdGZp
bHRlcihzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3Qgbmxtc2doZHIgKm4sCiAJCXJldHVybiAt
RU5PRU5UOwogCX0KIAotCS8qIEZpbmQgaGVhZCBvZiBmaWx0ZXIgY2hhaW4uICovCi0KLQllcnIg
PSBfX3RjZl9xZGlzY19maW5kKG5ldCwgJnEsICZwYXJlbnQsIHQtPnRjbV9pZmluZGV4LCBmYWxz
ZSwgZXh0YWNrKTsKLQlpZiAoZXJyKQotCQlyZXR1cm4gZXJyOwotCiAJaWYgKHRjZl9wcm90b19j
aGVja19raW5kKHRjYVtUQ0FfS0lORF0sIG5hbWUpKSB7CiAJCU5MX1NFVF9FUlJfTVNHKGV4dGFj
aywgIlNwZWNpZmllZCBUQyBmaWx0ZXIgbmFtZSB0b28gbG9uZyIpOwotCQllcnIgPSAtRUlOVkFM
OwotCQlnb3RvIGVycm91dDsKKwkJcmV0dXJuIC1FSU5WQUw7CiAJfQotCS8qIFRha2UgcnRubCBt
dXRleCBpZiBibG9jayBpcyBzaGFyZWQgKG5vIHFkaXNjIGZvdW5kKSwgcWRpc2MgaXMgbm90Ci0J
ICogdW5sb2NrZWQsIGNsYXNzaWZpZXIgdHlwZSBpcyBub3Qgc3BlY2lmaWVkLCBjbGFzc2lmaWVy
IGlzIG5vdAotCSAqIHVubG9ja2VkLgotCSAqLwotCWlmICgocSAmJiAhKHEtPm9wcy0+Y2xfb3Bz
LT5mbGFncyAmIFFESVNDX0NMQVNTX09QU19ET0lUX1VOTE9DS0VEKSkgfHwKLQkgICAgIXRjZl9w
cm90b19pc191bmxvY2tlZChuYW1lKSkgeworCXByb3RvX2lzX3VubG9ja2VkID0gdGNmX3Byb3Rv
X2lzX3VubG9ja2VkKG5hbWUsIGZhbHNlKTsKKworCWlmICghcGFyZW50X2lzX2luZ3Jlc3Nfb3Jf
ZWdyZXNzKHBhcmVudCkpIHsKKwkJcnRubF9oZWxkID0gdHJ1ZTsKKwkJcnRubF9sb2NrKCk7CisJ
fQorCisJLyogRmluZCBoZWFkIG9mIGZpbHRlciBjaGFpbi4gKi8KKwllcnIgPSBfX3RjZl9xZGlz
Y19maW5kKG5ldCwgJnEsICZwYXJlbnQsIHQtPnRjbV9pZmluZGV4LCBydG5sX2hlbGQsCisJCQkg
ICAgICAgZXh0YWNrKTsKKwlpZiAoZXJyKSB7CisJCWlmIChydG5sX2hlbGQpCisJCQlydG5sX3Vu
bG9jaygpOworCQlyZXR1cm4gZXJyOworCX0KKyAgICAgICAvKiBUYWtlIHJ0bmwgbXV0ZXggaWYg
Y2xhc3NpZmllciB0eXBlIGlzIG5vdCBzcGVjaWZpZWQsIG9yIGNsYXNzaWZpZXIgaXMKKwkqIG5v
dCB1bmxvY2tlZC4KKwkqLworCWlmICghcnRubF9oZWxkICYmICFwcm90b19pc191bmxvY2tlZCkg
ewogCQlydG5sX2hlbGQgPSB0cnVlOwogCQlydG5sX2xvY2soKTsKIAl9CkBAIC0zNDAzLDcgKzM0
NTcsNyBAQCBpbnQgdGNmX2V4dHNfdmFsaWRhdGVfZXgoc3RydWN0IG5ldCAqbmV0LCBzdHJ1Y3Qg
dGNmX3Byb3RvICp0cCwgc3RydWN0IG5sYXR0ciAqKgogCiAJCQlmbGFncyB8PSBUQ0FfQUNUX0ZM
QUdTX1BPTElDRSB8IFRDQV9BQ1RfRkxBR1NfQklORDsKIAkJCWFfbyA9IHRjX2FjdGlvbl9sb2Fk
X29wcyh0YltleHRzLT5wb2xpY2VdLCBmbGFncywKLQkJCQkJCSBleHRhY2spOworCQkJCQkJIDEs
IGV4dGFjayk7CiAJCQlpZiAoSVNfRVJSKGFfbykpCiAJCQkJcmV0dXJuIFBUUl9FUlIoYV9vKTsK
IAkJCWFjdCA9IHRjZl9hY3Rpb25faW5pdF8xKG5ldCwgdHAsIHRiW2V4dHMtPnBvbGljZV0sCg==
--000000000000c66a7c064e01e491--

