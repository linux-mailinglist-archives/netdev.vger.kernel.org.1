Return-Path: <netdev+bounces-36511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 422687B0137
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 12:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E719128199A
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 10:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60EF266D1;
	Wed, 27 Sep 2023 10:04:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A697733F1
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 10:04:05 +0000 (UTC)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7319CC0
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 03:04:04 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c4194f769fso78542825ad.3
        for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 03:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695809044; x=1696413844; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kn21YALmVe1WgKjf30uevEsxrBmnZaiJ1RAcok2vceU=;
        b=h9I6V2NMvB6tO1UNtjPNDaDi+J/3JZjnOc7+abZUhkIznZ53BtdfDZzYQMZ7SZ6RW8
         aH3lA03VZt6TopFYLG5VjXTcwxM5Jii0X1ms/ATfgiCVekxbWUq2Ga7e9F/o1y3cFPqd
         rBPqNrNVPcwSkr2n92ooVOz++CxqXXUjqcvQACOUcMXB8gFEsSsYUWqejkfuT+5p+cl7
         AWCD7JjoRgYBoPCYokY290Jb7eqGVtRuP0JTRqotbRIZD92kSmUTUW7P//eL70cOGal9
         BNvYZxb69qvlu2izEDUbIRnGj/Zp7398hO7lUoXFPt1gFk/lrnaqWx788YJ3fziLEFx7
         beHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695809044; x=1696413844;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Kn21YALmVe1WgKjf30uevEsxrBmnZaiJ1RAcok2vceU=;
        b=umtZwb96Mez0zn/T1VdoSwTGd+6YdeuVe+t0JAHbpuKAVs2bqKwPdg3838ddbD22Z4
         ihD/gfasQWbQFCQYVIrmE3goMsti/og0mLMR/rjNGO5kBteH/mzaU7lo8XmL3uCmPOn5
         k9vIyPsGGfdbqurQRd+grqn/BkOo2h3cKd1LaN3bDfVm/CEGxWdLZj8gwoWT44S3a1XY
         SPb+5BeuR+wgl8ZD1mYmVzzroQzx4cXlbTNOgP56WfZ6pohpvWi8AiPj9honp4XiTT20
         9uwNeb1HCV863uBGtx4kc/5qmKsaPTnZ23+9mH5PPKJcE1lA3EI7odi+CBa9fy1ZPlnD
         jViA==
X-Gm-Message-State: AOJu0YyT+1EfyGwo8E7luLzGzIMKNwNFwwtTdAJVy57Z3k45IvcS9Fm/
	8bapwSedlf5LJEEd060DNgRGSt2P2vk=
X-Google-Smtp-Source: AGHT+IGH1wqT8Y367mTT+4JjYRMNn5CBW2lgUTbBPIgyxvYXH8XLPsvzHOwuPT9PYLl+mUfmaA38/A==
X-Received: by 2002:a17:903:228f:b0:1bc:3944:9391 with SMTP id b15-20020a170903228f00b001bc39449391mr1379007plh.25.1695809043714;
        Wed, 27 Sep 2023 03:04:03 -0700 (PDT)
Received: from localhost ([203.63.110.121])
        by smtp.gmail.com with ESMTPSA id ju4-20020a170903428400b001c5684aed57sm12708680plb.218.2023.09.27.03.04.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 03:04:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 Sep 2023 20:03:58 +1000
Message-Id: <CVTM4TIZ9UKY.31MZSPM3JC67F@wheely>
Cc: <dev@openvswitch.org>
Subject: Re: [ovs-dev] [RFC PATCH 1/7] net: openvswitch: Move NSH buffer out
 of do_execute_actions
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Ilya Maximets" <i.maximets@ovn.org>, <netdev@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <20230927001308.749910-1-npiggin@gmail.com>
 <20230927001308.749910-2-npiggin@gmail.com>
 <8dc83d57-3e92-1d50-321c-fff6fde58bac@ovn.org>
In-Reply-To: <8dc83d57-3e92-1d50-321c-fff6fde58bac@ovn.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed Sep 27, 2023 at 6:26 PM AEST, Ilya Maximets wrote:
> On 9/27/23 02:13, Nicholas Piggin wrote:
> > This takes do_execute_actions stack use from 544 bytes to 288
> > bytes. execute_push_nsh uses 336 bytes, but it is a leaf call not
> > involved in recursion.
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  net/openvswitch/actions.c | 27 +++++++++++++++++----------
> >  1 file changed, 17 insertions(+), 10 deletions(-)
>
> Hi, Nicholas.  I made the same change about a week ago:
>   https://lore.kernel.org/netdev/20230921194314.1976605-1-i.maximets@ovn.=
org/
> So, you can drop this patch from your set.

Ah nice, I didn't see it. Looks good to me.

Thanks,
Nick

>
> Best regards, Ilya Maximets.
>
> >=20
> > diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> > index fd66014d8a76..8933caa92794 100644
> > --- a/net/openvswitch/actions.c
> > +++ b/net/openvswitch/actions.c
> > @@ -1286,6 +1286,21 @@ static int execute_dec_ttl(struct sk_buff *skb, =
struct sw_flow_key *key)
> >  	return 0;
> >  }
> > =20
> > +static noinline_for_stack int execute_push_nsh(struct sk_buff *skb,
> > +					       struct sw_flow_key *key,
> > +					       const struct nlattr *attr)
> > +{
> > +	u8 buffer[NSH_HDR_MAX_LEN];
> > +	struct nshhdr *nh =3D (struct nshhdr *)buffer;
> > +	int err;
> > +
> > +	err =3D nsh_hdr_from_nlattr(attr, nh, NSH_HDR_MAX_LEN);
> > +	if (likely(!err))
> > +		err =3D push_nsh(skb, key, nh);
> > +
> > +	return err;
> > +}
> > +
> >  /* Execute a list of actions against 'skb'. */
> >  static int do_execute_actions(struct datapath *dp, struct sk_buff *skb=
,
> >  			      struct sw_flow_key *key,
> > @@ -1439,17 +1454,9 @@ static int do_execute_actions(struct datapath *d=
p, struct sk_buff *skb,
> >  			err =3D pop_eth(skb, key);
> >  			break;
> > =20
> > -		case OVS_ACTION_ATTR_PUSH_NSH: {
> > -			u8 buffer[NSH_HDR_MAX_LEN];
> > -			struct nshhdr *nh =3D (struct nshhdr *)buffer;
> > -
> > -			err =3D nsh_hdr_from_nlattr(nla_data(a), nh,
> > -						  NSH_HDR_MAX_LEN);
> > -			if (unlikely(err))
> > -				break;
> > -			err =3D push_nsh(skb, key, nh);
> > +		case OVS_ACTION_ATTR_PUSH_NSH:
> > +			err =3D execute_push_nsh(skb, key, nla_data(a));
> >  			break;
> > -		}
> > =20
> >  		case OVS_ACTION_ATTR_POP_NSH:
> >  			err =3D pop_nsh(skb, key);


