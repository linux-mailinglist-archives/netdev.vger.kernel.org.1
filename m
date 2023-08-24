Return-Path: <netdev+bounces-30353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D1B786FE7
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 15:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DA1A1C20E5B
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 13:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F259E288F9;
	Thu, 24 Aug 2023 13:07:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63F9288E6
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 13:07:43 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C954F198
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 06:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692882462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2y22yXp1HqXR+slOXCwonsb1aba1J3Dsh2mqYuR4WVs=;
	b=igOaE21QyyFEiiQuReX/usqX+gud1UeiHK1uSsIKvnrXnyqdIZAKulOPuCEaYujxBerOvs
	CFyfs2yM7NuofsLZBj6NqAanpz2Ln5GoowS74pBokTo6spWA4Wf3XtqRyR6lAVPQLQ9qGr
	GlqvUocBFMH830Wi88y3L61fkWCwknU=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-DaSj0YK2ONSDlPmsDM84zw-1; Thu, 24 Aug 2023 09:07:40 -0400
X-MC-Unique: DaSj0YK2ONSDlPmsDM84zw-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2bcc0c073ffso9536641fa.1
        for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 06:07:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692882459; x=1693487259;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2y22yXp1HqXR+slOXCwonsb1aba1J3Dsh2mqYuR4WVs=;
        b=b1Ye03RQqwL9dS8IW9yBObKPtcB7je+H76UUUZIH0FhG8Og+ph8hzFs/z0fvmheJLt
         TuEHYSeNjwwhs5jU7YefMJhDo1csF3PW1K76nmdrT/hnS9ePmAG6sMjy96xo4VGCDFN9
         WOiENO/J+/pCb9eenIWwk4ahrCsObrSUcv7XLkX1wS//onAD6u8GS54SPwv4bgBHC9RT
         idLuJBtb6p9O2FHsQ/fHm6j6LbeU41E3C2/+n6u+QS3nO0fOR5NNLm+rc0WH3vzhvuk0
         2TKOtN4qIARZKByKYKfrr/4glxkNDB/8bsss1AhuwVRhd0VJF1uVNdSIGbuSEQtptRj/
         VGnw==
X-Gm-Message-State: AOJu0YyHZZ55i7GPgJDEMU8Dm3is16ht3cYCCfTu5kKmdP9e9JHH4h7s
	0nlfY0B6iPr1Vre1MQTyHGLDXgyysYdiTtz1JRfB1+i2p7wAvgx39yVPROEo/z9DG82VGYNwXEz
	3TZdrWEeMhp+TmXpv
X-Received: by 2002:a05:651c:19a4:b0:2b6:a882:129c with SMTP id bx36-20020a05651c19a400b002b6a882129cmr13481953ljb.0.1692882459042;
        Thu, 24 Aug 2023 06:07:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBDE8a5cy1Iy07KLPEhgzC4JCJtm5uq8wOZAj/AInMP2yWdFU1D01mE/j6XfCMbacZ7wOVKg==
X-Received: by 2002:a05:651c:19a4:b0:2b6:a882:129c with SMTP id bx36-20020a05651c19a400b002b6a882129cmr13481934ljb.0.1692882458678;
        Thu, 24 Aug 2023 06:07:38 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-4.dyn.eolo.it. [146.241.241.4])
        by smtp.gmail.com with ESMTPSA id lg5-20020a170906f88500b009937dbabbd5sm10837409ejb.220.2023.08.24.06.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 06:07:38 -0700 (PDT)
Message-ID: <9c9d27044121c67e096f2e8edc7e61c507c8474b.camel@redhat.com>
Subject: Re: [patch net-next] devlink: add missing unregister linecard
 notification
From: Paolo Abeni <pabeni@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 idosch@nvidia.com,  petrm@nvidia.com
Date: Thu, 24 Aug 2023 15:07:36 +0200
In-Reply-To: <ZOcQHYAcUwd+VguS@nanopsycho>
References: <20230817125240.2144794-1-jiri@resnulli.us>
	 <ZOcQHYAcUwd+VguS@nanopsycho>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On Thu, 2023-08-24 at 10:09 +0200, Jiri Pirko wrote:
> Kuba, do you plan to merge net into net-next any time soon? I have
> another patchset depending on this.
>=20
> Btw, I aimed this to net-next on purpose, in net it does not make much
> sense imho.

That patch has been applied to net.

Today we have sent the PR for -net to Linus. Hopefully it should be
merged into vanilla soon, and shortly after that, net will be merged
back into net-next.=C2=A0

Usually that happen by the end of the day (european time).

Cheers,

Paolo


