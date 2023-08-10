Return-Path: <netdev+bounces-26563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 054EE778255
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 22:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEDBB1C20D3A
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 20:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB6422F02;
	Thu, 10 Aug 2023 20:49:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C0E20FB3
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 20:49:58 +0000 (UTC)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B602737
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 13:49:57 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-34961362f67so6428015ab.0
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 13:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691700597; x=1692305397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IrPtI7WuVK/oaLBJhxp0over27m1houzlRFCqoHRsZI=;
        b=FefyM5boM+iZbD5HCFP6q7YdNjfhM4Crf149F1xn2YjT84k7yzbFnUm4EO4WcJBcZ+
         aEq9gMUJrhGCPkZaVrruWI0GixWkHHRk0W1/MSLywlOf6fFJM1mBanu5xUpziUnJymb6
         wyMDdWSPzAnOugSUbmiwqmUPrwD+Vxc4coHCD6T4B3h9E7dP/vncsfUtROT2l1kYs4Bj
         HkVbnH6HdttJ4QgZB0j6943Pt0v6CrrXpVyV2ss+wRQ9mqjk5Vvo9SKj9Kok2GSWDeBT
         kPTFXzES0QKtjF2Jz0+naAIStbwstX0nqX+vIjBACvmYnlYxgerfm5rQEcA5u63Q2KVm
         qAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691700597; x=1692305397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IrPtI7WuVK/oaLBJhxp0over27m1houzlRFCqoHRsZI=;
        b=SODpmv+PrfH0/CDO0e1E8kifCL3J2y1HoDLIg5hixs8u6ITXs68V2UAsaYckzURKEm
         mssAepc7rOJHZZyU04vRFFmRh6gAp3LfxsLBAOkwA+/pMj/KTpGQPLKJsY78jPsQGpFr
         tdIJdA2LwP5JGu9+4vtHPN4S8FlIfEvBvgBKsMlbFW0VchN9lO8yFX+BQXNAJ4RXnefq
         T1V+HnGw+BCcjbTacsAk8WRazUBOcH0b0AfxisQxAkl6R6QB6BQ6zP7Mjf7ysIIkVmR0
         2ncRdZEvyLaUycqiXA2Ti9z1C7dU5jbzdxALLsM7Ff1iaMpWB2k/AwN9wuY4SkBJhzD9
         Dpkw==
X-Gm-Message-State: AOJu0YzDboGwSoXrbH2PrVrYbpUgG7nxdCHDcC42h2hgndqSH/7WsQrt
	poy8lCK0/l3Ng89b1XCuCSKNyNjo0c9xU1rhnRO38A==
X-Google-Smtp-Source: AGHT+IEwEFZIXKpAeifAuxh0Eqsxgobltmkf4dACqcHcGYNcVSpVavL7FAFg27OJnH28qQrTLzgHWA==
X-Received: by 2002:a92:c54f:0:b0:348:b07e:fdac with SMTP id a15-20020a92c54f000000b00348b07efdacmr51572ilj.3.1691700596858;
        Thu, 10 Aug 2023 13:49:56 -0700 (PDT)
Received: from google.com (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id u9-20020a92da89000000b003487840f1d3sm658566iln.50.2023.08.10.13.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 13:49:56 -0700 (PDT)
Date: Thu, 10 Aug 2023 20:49:53 +0000
From: Justin Stitt <justinstitt@google.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/4][next] i40e: Replace one-element array with
 flex-array member in struct i40e_profile_segment
Message-ID: <20230810204953.wwwvbl57m3cebf27@google.com>
References: <cover.1690938732.git.gustavoars@kernel.org>
 <52da391229a45fe3dbd5c43167cdb0701a17a361.1690938732.git.gustavoars@kernel.org>
 <20230810173404.jjuvqo5tv57en7pg@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810173404.jjuvqo5tv57en7pg@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 10, 2023 at 05:34:04PM +0000, Justin Stitt wrote:
> On Tue, Aug 01, 2023 at 11:05:59PM -0600, Gustavo A. R. Silva wrote:
> > One-element and zero-length arrays are deprecated. So, replace
> > one-element array in struct i40e_profile_segment with flexible-array
> > member.
> >
> > This results in no differences in binary output.
> >
> > Link: https://github.com/KSPP/linux/issues/335
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> >  drivers/net/ethernet/intel/i40e/i40e_type.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> Tested-by: Justin Stitt <justinstitt@google.com>
Whoops, this should be:
Reviewed-by: Justin Stitt <justinstitt@google.com>

I did not test, I just verified there are no binary differences produced
by this patch.

>
> >
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
> > index c3d5fe12059a..f7a984304b65 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_type.h
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
> > @@ -1487,7 +1487,7 @@ struct i40e_profile_segment {
> >  	struct i40e_ddp_version version;
> >  	char name[I40E_DDP_NAME_SIZE];
> >  	u32 device_table_count;
> > -	struct i40e_device_id_entry device_table[1];
> > +	struct i40e_device_id_entry device_table[];
> >  };
> >
> >  struct i40e_section_table {
> > --
> > 2.34.1
> >

