Return-Path: <netdev+bounces-38292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC3C7BA0BA
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 16:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id E8CF71F233CD
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 14:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A0D2AB41;
	Thu,  5 Oct 2023 14:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UQ/8vbZu"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E838F1D698
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 14:42:48 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300ED29B35
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 07:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696516933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EcYpFc5fQ2y3uLxjaGAy7lsrM21+5zwRHwXefFI3p3Q=;
	b=UQ/8vbZuGoQ9t158NccRXBVxt79EErtuzCofWy6hSIISWc6s+8Vq1VXPaRE6OzELi2AAhM
	gR4EoYTrwTuEYhCDHA5jgTcB7T7nSxIBc+oTTpVJ9gtxbAvQh5WFuLi/bfp3K8JCfPLY66
	+h6jilfhuBiA6Gtlzy7TWrS76idN5hM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-vjSSkmL7M4GhkEwbLrB0TA-1; Thu, 05 Oct 2023 06:39:09 -0400
X-MC-Unique: vjSSkmL7M4GhkEwbLrB0TA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9b989422300so19028966b.0
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 03:39:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696502348; x=1697107148;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EcYpFc5fQ2y3uLxjaGAy7lsrM21+5zwRHwXefFI3p3Q=;
        b=vmrt1XiP4QyhSMByNlmZ/k6M9Z6KYcq6nIOVUo5My3PMcc/gZWjYaWKhbMJuIXLNPy
         EfIdIJZHWIbDg1YSI2w3llsb1JDxnEP/UcFkw3EeQGuFlPIjlpNndyVEN+bJx+zp8GaS
         ohYUf7N2GlEtEWisqRB4RQ008v9CDbE2ekVN+S0yjfYiLeA3z8ekq7w9H/cJUAiRuPnP
         AyHa8h7iW0ra7KGq/WL81BziKltOEXEqX7Y3Agy0UMQB2yKAPmJTniCPnCmp6GsaRzkg
         cUVJ7e465rvpkPU83DOKH+IklF/k68Amo9Ee6KXEafy6qoqYsW9WWzacPavZSXKtAR/G
         OZnA==
X-Gm-Message-State: AOJu0Ywne+SBvq9Fqfdiw64i+JH4na7DSf2q3a2VUotWwg2ZtC+fDzCq
	xRWs7sxUKwowXJR1CcjdqtL7HNTATt00aZiXqjwLv+k7Y7wLilaV786mysNdYn3PNtMsIy1HabR
	+8CO7HMnjYQw9xFZU
X-Received: by 2002:a05:6402:5191:b0:51e:5dd8:fc59 with SMTP id q17-20020a056402519100b0051e5dd8fc59mr4227639edd.1.1696502348314;
        Thu, 05 Oct 2023 03:39:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXoi9NQo5thKA2z7QAg6O6iVK7LWh7JCWMxNO5nWP25rBMF90nlazkgDGpx4ETuytneK118Q==
X-Received: by 2002:a05:6402:5191:b0:51e:5dd8:fc59 with SMTP id q17-20020a056402519100b0051e5dd8fc59mr4227628edd.1.1696502347918;
        Thu, 05 Oct 2023 03:39:07 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-225-9.dyn.eolo.it. [146.241.225.9])
        by smtp.gmail.com with ESMTPSA id y20-20020aa7d514000000b00537708be5c6sm869929edq.73.2023.10.05.03.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 03:39:07 -0700 (PDT)
Message-ID: <2554ed057e08e66dd110c3e09a27378b9a06bdd6.camel@redhat.com>
Subject: Re: [PATCH 3/3] cnic,bnx2,bnx2x: use UIO_MEM_DMA_COHERENT
From: Paolo Abeni <pabeni@redhat.com>
To: Hannes Reinecke <hare@suse.de>, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>, Jerry Snitselaar <jsnitsel@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Chris Leech <cleech@redhat.com>, Rasesh
 Mody <rmody@marvell.com>, Ariel Elior <aelior@marvell.com>, Sudarsana
 Kalluru <skalluru@marvell.com>, Manish Chopra <manishc@marvell.com>, Nilesh
 Javali <njavali@marvell.com>, Manish Rangankar <mrangankar@marvell.com>,
 John Meneghini <jmeneghi@redhat.com>, Lee Duncan <lduncan@suse.com>, Mike
 Christie <michael.christie@oracle.com>, Hannes Reinecke <hare@kernel.org>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 05 Oct 2023 12:39:05 +0200
In-Reply-To: <0e0040be-0375-4461-914d-1ea9d04ee62c@suse.de>
References: <20230929170023.1020032-1-cleech@redhat.com>
	 <20230929170023.1020032-4-cleech@redhat.com>
	 <2023093055-gotten-astronomy-a98b@gregkh>
	 <ZRhmqBRNUB3AfLv/@rhel-developer-toolbox>
	 <2023093002-unlighted-ragged-c6e1@gregkh>
	 <e0360d8f-6d36-4178-9069-d633d9b7031d@suse.de>
	 <2023100114-flatware-mourner-3fed@gregkh>
	 <7pq4ptas5wpcxd3v4p7iwvgoj7vrpta6aqfppqmuoccpk4mg5t@fwxm3apjkez3>
	 <20231002060424.GA781@lst.de>
	 <tf2zu6gqaii2bjipbo2mn2hz64px2624rfcmyg36rkq4bskxiw@zgjzznig6e22>
	 <2023100233-salsa-joyous-6d8c@gregkh>
	 <0e0040be-0375-4461-914d-1ea9d04ee62c@suse.de>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-10-02 at 10:59 +0200, Hannes Reinecke wrote:
> On 10/2/23 10:46, Greg Kroah-Hartman wrote:
> > On Mon, Oct 02, 2023 at 12:50:21AM -0700, Jerry Snitselaar wrote:
> > > On Mon, Oct 02, 2023 at 08:04:24AM +0200, Christoph Hellwig wrote:
> > > > On Sun, Oct 01, 2023 at 07:22:36AM -0700, Jerry Snitselaar wrote:
> > > > > Changes last year to the dma-mapping api to no longer allow __GFP=
_COMP,
> > > > > in particular these two (from the e529d3507a93 dma-mapping pull f=
or
> > > > > 6.2):
> > > >=20
> > > > That's complete BS.  The driver was broken since day 1 and always
> > > > ignored the DMA API requirement to never try to grab the page from =
the
> > > > dma coherent allocation because you generally speaking can't.  It j=
ust
> > > > happened to accidentally work the trivial dma coherent allocator th=
at
> > > > is used on x86.
> > > >=20
> > >=20
> > > re-sending since gmail decided to not send plain text:
> > >=20
> > > Yes, I agree that it has been broken and misusing the API. Greg's
> > > question was what changed though, and it was the clean up of
> > > __GFP_COMP in dma-mapping that brought the problem in the driver to
> > > light.
> > >=20
> > > I already said the other day that cnic has been doing this for 14
> > > years. I'm not blaming you or your __GFP_COMP cleanup commits, they
> > > just uncovered that cnic was doing something wrong. My apologies if
> > > you took it that way.
> >=20
> > As these devices aren't being made anymore, and this api is really not =
a
> > good idea in the first place, why don't we just leave it broken and see
> > if anyone notices?
> >=20
> Guess what triggered this mail thread.
> Some customers did notice.
>=20
> Problem is that these devices were built as the network interface in=20
> some bladecenter machines, so you can't just replace them with a=20
> different Ethernet card.

This route looks a no-go.

Out of sheer ignorance, would the iommu hack hinted in the cover letter
require similar controversial changes?

Cheers,

Paolo


