Return-Path: <netdev+bounces-26493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F11E7777F38
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 19:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC04C28219D
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 17:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E29214EB;
	Thu, 10 Aug 2023 17:34:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E671E1C0
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 17:34:09 +0000 (UTC)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32299270F
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 10:34:08 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-790fef20fafso57217939f.0
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 10:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691688847; x=1692293647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GdV4iR1xxtboZs5FQPuJUZtXcGLHtIDsoRCRiJm05c4=;
        b=f49m7e0fTpMvMzTJELh+6sHJ1ejSFDxI40Hzkiwl3GIxcq/hxl/PROqKNx//p59fGK
         pB6pv72ip3SU34UFbF4JTU1fUHt+t/ecMn+3dXUwoPjoTg+hhoNRqsE+q+F9PzLsOWih
         Eug9n5HfoEAkeL3oP9HcAWidpQzyXF3r3BjPr1kJtYmDv9gJXfZYNpJ69K4NBlV26aTb
         47DUVLNEHv9xIzbXdB7wZzHLYiz2AwWEYlB6BL3hiBmZbHckPxQo4gZG6oYYulEFDQfz
         UIIzRB88jqmCOW7O4bx64FM7jd8t3u6dYQ1HRCNl2FCf+wOJHkdrHYp+O0bGDjrAFUEf
         Of3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691688847; x=1692293647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdV4iR1xxtboZs5FQPuJUZtXcGLHtIDsoRCRiJm05c4=;
        b=d9GuhjdNNvJXO0r1pYXIOkZAjuHB2Bg/R6zjwP6HljB3owgEgoFsa5Z/j4CzMGWIz0
         XAD2R55TeJbfC0XXWCWr8j2TjC2J2DxfYQeI/Q67EvmmC9frA3sccpipVuT7MdmmZZ3y
         +Z73rKwpUh2l8ss8sVh23LsOPPMuvgOVzVOLRckXhNuhiusJ4Z7POQUJvsdlxCI3lr/o
         bSdymg+vjBjJH6vDyjYtylHNAYULjqi3w9DDLUGV+ud/FglPLQHOgHwcmNKNrLIWV/xZ
         llG6ngvzpXHJQ6lUAqtZuE7GowzuJw6fFzJbKvx4RMrMzIbfQAf8pp841SCYaOqc+Io2
         C3dQ==
X-Gm-Message-State: AOJu0Yxxszbw+5RqNYKWL5hABzZThIrJ3G8wLB3djkajAj2z1h3bWZ5Y
	rRIPjHyYWTD0BBefJuiiKOHxcg==
X-Google-Smtp-Source: AGHT+IFjuDr680+2jafpw07ddfS/d3QHLVYJH7X3GvqWM5wSrbwFXF5hRN0rsbXDvNUnU1YujztEDw==
X-Received: by 2002:a05:6e02:1baf:b0:349:46fa:3844 with SMTP id n15-20020a056e021baf00b0034946fa3844mr2889307ili.3.1691688847549;
        Thu, 10 Aug 2023 10:34:07 -0700 (PDT)
Received: from google.com (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id l17-20020a92d8d1000000b00345d2845c42sm566851ilo.57.2023.08.10.10.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 10:34:06 -0700 (PDT)
Date: Thu, 10 Aug 2023 17:34:04 +0000
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
Message-ID: <20230810173404.jjuvqo5tv57en7pg@google.com>
References: <cover.1690938732.git.gustavoars@kernel.org>
 <52da391229a45fe3dbd5c43167cdb0701a17a361.1690938732.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52da391229a45fe3dbd5c43167cdb0701a17a361.1690938732.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 01, 2023 at 11:05:59PM -0600, Gustavo A. R. Silva wrote:
> One-element and zero-length arrays are deprecated. So, replace
> one-element array in struct i40e_profile_segment with flexible-array
> member.
>
> This results in no differences in binary output.
>
> Link: https://github.com/KSPP/linux/issues/335
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_type.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
Tested-by: Justin Stitt <justinstitt@google.com>

>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
> index c3d5fe12059a..f7a984304b65 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_type.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
> @@ -1487,7 +1487,7 @@ struct i40e_profile_segment {
>  	struct i40e_ddp_version version;
>  	char name[I40E_DDP_NAME_SIZE];
>  	u32 device_table_count;
> -	struct i40e_device_id_entry device_table[1];
> +	struct i40e_device_id_entry device_table[];
>  };
>
>  struct i40e_section_table {
> --
> 2.34.1
>

