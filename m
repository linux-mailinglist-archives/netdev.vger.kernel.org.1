Return-Path: <netdev+bounces-38583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B198A7BB814
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 14:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E20671C2098F
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 12:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBBF1D69F;
	Fri,  6 Oct 2023 12:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AerCDRue"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5CC1CA93
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 12:49:45 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7EBC6
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 05:49:44 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4056ce55e7eso18622475e9.2
        for <netdev@vger.kernel.org>; Fri, 06 Oct 2023 05:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696596582; x=1697201382; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oHjBNst/lhil+UcE/qDI5coR6SVyilLvcP6sMcHytls=;
        b=AerCDRuezhOwH+X4RX6pC/yUdwS9mqzaDmw52jg11c8+LY2ymgKBsep2sXcM5rMMfY
         hO6PZsME6MzRHbrJrR4tfgjiV9vb01eNZJ5UBpZpEEBKSwtuzcCknMl3qxJyFKENZhN2
         OHWcE7li7dyfZuumlRHOoYaOvmB5Xgsswoc+Jnts06mTsqxoS/oUGG9J7ZsSs46Imeig
         3LwLB1rr5uscUfbn1c/YqEJoYFeNYGaIek6egfls9BWkixBSxOG8l6ucGBHczSWT3U+D
         BhGi+FdJ5OfxBnU4XluFomXgk82vggNYHJXRG1nTFzUuoSJmMC0p4JMf4EGqwPgij6yE
         TIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696596582; x=1697201382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oHjBNst/lhil+UcE/qDI5coR6SVyilLvcP6sMcHytls=;
        b=ZOxfhdrnWIWrxG3oohExdkNHd9yBsaomoot5owbL5PICMhceDPbtzZAfmDTkKfdJj8
         lJv7QXHdL2x9/QGki6UkozOe4r9ubpw0O9wwx9erxMqLggML9G2XHhToSZE0LA9MWzZw
         s8/TIk8Lfrvik769A/56jDHZg0VynoSAiR81JzopFHDgU8VINjohER+gyEpV89I1yTmt
         ABcL/yZb401TAsALBjdjpN1YWMPciO8xvIbpfuf0EfLjurTas1k2V2zh886KMyh94XZd
         uDdOgTZrnmfjvZCP7ah8TScKTdQY9eBlrLNmcD2Uh+RuZFR9xZa3NwkND1ECGmiCClUg
         AQyA==
X-Gm-Message-State: AOJu0YymLkfmVA2WeoE8VgOJSdoQUK5uV6M5uRc11E3+PhIF7cNiHK/A
	J3cbgtfy0iiWvIs0T/5uZv0elvnFZN1R6++6qsI=
X-Google-Smtp-Source: AGHT+IErZT4Z9JOnQab8/UPM9P5VYK8b44c4GNP61Z9e5SRanKoOeNOUL0LBngvKhNZHSCtY36Ax5g==
X-Received: by 2002:adf:ecd2:0:b0:317:e1fb:d57b with SMTP id s18-20020adfecd2000000b00317e1fbd57bmr6910194wro.56.1696596582480;
        Fri, 06 Oct 2023 05:49:42 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v7-20020adfedc7000000b003197efd1e7bsm1563290wro.114.2023.10.06.05.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 05:49:41 -0700 (PDT)
Date: Fri, 6 Oct 2023 15:49:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Simon Horman <horms@kernel.org>
Cc: Greg Rose <gregory.v.rose@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] ixgbe: fix crash with empty VF macvlan list
Message-ID: <569ba96b-2bc3-45ea-b397-36e7ef88ed8f@kadam.mountain>
References: <3cee09b8-4c49-4a39-b889-75c0798dfe1c@moroto.mountain>
 <ZR/si/di5IbSB9Gq@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZR/si/di5IbSB9Gq@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 06, 2023 at 01:16:27PM +0200, Simon Horman wrote:
> On Thu, Oct 05, 2023 at 04:57:02PM +0300, Dan Carpenter wrote:
> > The adapter->vf_mvs.l list needs to be initialized even if the list is
> > empty.  Otherwise it will lead to crashes.
> > 
> > Fixes: c6bda30a06d9 ("ixgbe: Reconfigure SR-IOV Init")
> 
> Hi Dan,
> 
> I see that the patch cited above added the line you are changing.
> But it also seems to me that patch was moving it from elsewhere.
> 
> Perhaps I am mistaken, but I wonder if this is a better tag.
> 
> Fixes: a1cbb15c1397 ("ixgbe: Add macvlan support for VF")
> 

Yeah.  You're right.  I'll resend.


> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> > index a703ba975205..9cfdfa8a4355 100644
> > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c
> > @@ -28,6 +28,9 @@ static inline void ixgbe_alloc_vf_macvlans(struct ixgbe_adapter *adapter,
> >  	struct vf_macvlans *mv_list;
> >  	int num_vf_macvlans, i;
> >  
> > +	/* Initialize list of VF macvlans */
> > +	INIT_LIST_HEAD(&adapter->vf_mvs.l);
> > +
> >  	num_vf_macvlans = hw->mac.num_rar_entries -
> >  			  (IXGBE_MAX_PF_MACVLANS + 1 + num_vfs);
> >  	if (!num_vf_macvlans)
> > @@ -36,8 +39,6 @@ static inline void ixgbe_alloc_vf_macvlans(struct ixgbe_adapter *adapter,
> >  	mv_list = kcalloc(num_vf_macvlans, sizeof(struct vf_macvlans),
> >  			  GFP_KERNEL);
> >  	if (mv_list) {
> 
> I'm not sure it it is worth it, but perhaps more conventional error
> handling could be used here:
> 
> 	if (!mv_list)
> 		return;
> 
> 	for (i = 0; i < num_vf_macvlans; i++) {
> 		...

I mean error handling is always cleaner than success handling but it's
probably not worth cleaning up in old code.  I say it's not worth
cleaning up old code and yet I secretly reversed two if statements like
this yesterday.  :P
https://lore.kernel.org/all/d9da4c97-0da9-499f-9a21-1f8e3f148dc1@moroto.mountain/
It really is nicer, yes.  But it just makes the patch too noisy.

regards,
dan carpenter


