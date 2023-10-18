Return-Path: <netdev+bounces-42343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 530DE7CE5F9
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 20:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E77FAB20ED4
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 18:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D6A3FE55;
	Wed, 18 Oct 2023 18:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2K0V8Sq"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531283FB33;
	Wed, 18 Oct 2023 18:12:52 +0000 (UTC)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A62BB6;
	Wed, 18 Oct 2023 11:12:50 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5ae99bb5ccdso2898655a12.1;
        Wed, 18 Oct 2023 11:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697652770; x=1698257570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6GMn7cpKzACEI5MaPrz+Tfss8qgnZd3IVim37pXeBs=;
        b=f2K0V8SqWW+Zt/01FNhQDn+iHMPhW85Ok80T9q98ti1Q7vi0JoKMvmGfULpgLeye8n
         B8F06tnMlPvQLFRb1Xm6Xbgoy3/cVov6+2imOYp83MLuEqTdfxj3GnZ7jyl4MqO+XU9x
         SBdMYD8VUAmDLV097eowb+ygo/yBQT0zKwS3ymvh0R/dyrAlxx0wSs05GIrLU1jmFJ9F
         hv1XMRRXf0Mk1nd6WCXtc9RVa0e0npBkBGrvAQEHta58bd4hPwheaNYc0Ye+9tS8r9kf
         oEywEISL06SoYIQcEUc9zWw8C19M4PXqVDrEZunIvL9YFQg8nwkTLZqkwudd9xN42hxz
         Su0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697652770; x=1698257570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6GMn7cpKzACEI5MaPrz+Tfss8qgnZd3IVim37pXeBs=;
        b=nwkl3mQsvnzcrILyJPcLt3P+AkhvEB8VLiXeUy8XfV771ZOGOtCvlF6tYQG83mfAEx
         X70CJfRLECbOyaU1JP3lidt+I6sH5lrX0qqazVvc0PTpoFHkoEAPhCv1wQyP73HxCN7O
         IsTxBxz2E90x0/OThEKxh5u/qXAWYN/5u2UQ0WuJz9ZE0ygYbOsifG3sm35SY2chb2DS
         K5Wn6EmZZH773ua7vXINCl+fVSvovsXOBVEqi3BTwV6DxHSXWtkuV305S+28Ai6UXrpy
         nRoo+C0rU54K2UJF5oxmr6SXUrEAqUZp3VdfLD/JC9bGBIMByWcPOSZ55W/AGG/2+3el
         vrjw==
X-Gm-Message-State: AOJu0Yxi1QJjronm79smeIvJGkJWEDjXGjT5HC2JVYL7IT3Zr2WSCjE/
	C8lVNojIDGejhIvc5/iSJngz52Wk7/c9+0Nn/f4=
X-Google-Smtp-Source: AGHT+IFUWULTgFy6Wj6VevczJCO+C/6xYDTVrSlqNWMOrY8f9hNCaT5duJhriJka7CmTPYtih6ViXo1Ox2BHV9RzDkA=
X-Received: by 2002:a05:6a20:8f28:b0:16b:f3b1:c040 with SMTP id
 b40-20020a056a208f2800b0016bf3b1c040mr6402566pzk.38.1697652769936; Wed, 18
 Oct 2023 11:12:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016154937.41224-1-ahmed.zaki@intel.com> <20231016154937.41224-2-ahmed.zaki@intel.com>
 <8d1b1494cfd733530be887806385cde70e077ed1.camel@gmail.com>
 <26812a57-bdd8-4a39-8dd2-b0ebcfd1073e@intel.com> <CAKgT0Ud7JjUiE32jJbMbBGVexrndSCepG54PcGYWHJ+OC9pOtQ@mail.gmail.com>
 <14feb89d-7b4a-40c5-8983-5ef331953224@intel.com> <CAKgT0UfcT5cEDRBzCxU9UrQzbBEgFt89vJZjz8Tow=yAfEYERw@mail.gmail.com>
 <20231016163059.23799429@kernel.org> <CAKgT0Udyvmxap_F+yFJZiY44sKi+_zOjUjbVYO=TqeW4p0hxrA@mail.gmail.com>
 <20231017131727.78e96449@kernel.org> <CAKgT0Ud4PX1Y6GO9rW+Nvr_y862Cbv3Fpn+YX4wFHEos9rugJA@mail.gmail.com>
 <20231017173448.3f1c35aa@kernel.org>
In-Reply-To: <20231017173448.3f1c35aa@kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 18 Oct 2023 11:12:13 -0700
Message-ID: <CAKgT0Udz+YdkmtO2Gbhr7CccHtBbTpKich4er3qQXY-b2inUoA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/6] net: ethtool: allow symmetric-xor RSS
 hash for any flow type
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ahmed Zaki <ahmed.zaki@intel.com>, netdev@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, corbet@lwn.net, jesse.brandeburg@intel.com, 
	anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, vladimir.oltean@nxp.com, andrew@lunn.ch, horms@kernel.org, 
	mkubecek@suse.cz, willemdebruijn.kernel@gmail.com, linux-doc@vger.kernel.org, 
	Wojciech Drewek <wojciech.drewek@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 5:34=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 17 Oct 2023 13:41:18 -0700 Alexander Duyck wrote:
> > I am thinking of this from a software engineering perspective. This
> > symmetric-xor aka simplified-toeplitz is actually much cheaper to
> > implement in software than the original. As such I would want it to be
> > considered a separate algorithm as I could make use of something like
> > that when having to implement RSS in QEMU for instance.
>
> That's exactly why XOR and CRC32 _algorithms_ already exist.
> CPUs have instructions to do them word at a time.
>
>         ETH_RSS_HASH_TOP_BIT, /* Configurable RSS hash function -
>         Toeplitz */
>         ETH_RSS_HASH_XOR_BIT, /* Configurable RSS hash function - Xor */
>         ETH_RSS_HASH_CRC32_BIT, /* Configurable RSS hash function - Crc32=
 */
>
> If efficient SW implementation is important why do some weird
> bastardized para-toeplitz and not crc32? Hashes fairly well
> from what I recall with the older NFPs. x86 has an instruction
> for it, IIRC it was part of SSE but on normal registers.

If we want to not support that I would be fine with that too. In my
view this is about as secure as using the 16b repeating key.

> > Based on earlier comments it doesn't change the inputs, it just
> > changes how I have to handle the data and the key. It starts reducing
> > things down to something like the Intel implementation of Flow
> > Director in terms of how the key gets generated and hashed.
>
> About Flow Director I know only that it is bad :)

Yeah, and that is my concern w/ the symmetric XOR is that it isn't
good. It opens up the toeplitz hash to exploitation. You can target
the same bucket by just making sure that source IP and port XOR with
destination IP and port to the same value. That can be done by adding
the same amount to each side. So there are 2^144 easily predictable
possible combinations that will end up in the same hash bucket. Seems
like it might be something that could be exploitable. That is why I
want it marked out as a separate algo since it is essentially
destroying entropy before we even get to the Toeplitz portion of the
hash. As such it isn't a hash I would want to use for anything that is
meant to spread workload since it is so easily exploitable.

