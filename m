Return-Path: <netdev+bounces-40263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1B57C66B2
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 09:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 866F42827B6
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 07:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A9F12B94;
	Thu, 12 Oct 2023 07:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7AKuDVV"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAC2101C1;
	Thu, 12 Oct 2023 07:55:55 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3C8B7;
	Thu, 12 Oct 2023 00:55:53 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40684f53d11so8339605e9.1;
        Thu, 12 Oct 2023 00:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697097352; x=1697702152; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CI6wAmn/c75sowLMQ9qhx5ldBqSwgNt5iQ5ki2HUkx8=;
        b=S7AKuDVV3+Oi0eriBOo08mcZxjXgMPi4cD48J8M0oWz/mreEkB6uWsNYyCHEHgMSn1
         yHS+5/oD6+H/ZIR2D+EBHZnxRgLXD+xeBukwSelNGyo3271p9xcRJIizgFhjp9fPIKR/
         1i2szNGpZm9a52TDno04Iu1hyJZ+N/VAXlZWPsmuJqrVf0ViRDfAmZ+lLZioY+NolBI5
         o1mGx+KrWcWtbueupKmSzOWc5ZMC/gqudI7gMg+uzJghzangEeh5ZP7VhP8oK7C++gK4
         dfXyZ9P1kjRBqZxZtRQTR60Hc8RMGXOwBT0/IUr54tAx7PZqbG1yX8hnmVVx8ARB/M3R
         R+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697097352; x=1697702152;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CI6wAmn/c75sowLMQ9qhx5ldBqSwgNt5iQ5ki2HUkx8=;
        b=IxFpMXjdQ8t4X987OkUoQRCJFegVOMFlqzda8W07/DaF1MLWiZ1WfotOI/qhc0J8lQ
         gcR/eEohFqUkuQSQPPhXC/GKsAByQHaVi6ytkl+p4ocJn7J/Ouo+ma4MjQTneVDiiVQQ
         g3Mm+2rh/KIMdthpMoi2sYlkRr6tZmTFjUB+TcGmsmqK68PBJagVO/mF+PxqrPEeallQ
         acbH6iFnZm5bCGAJBskI6AiCHJyhDFMiGcd9mRbuiJKnHTpwE9eX1FGO1TvQiXkrJ2rd
         zU/O0mEGM91gGr1izEM6QIs36YqmCTBh1jbq9GwzoWNaoc2bmzPYOTtXh1E/r41PKzqd
         z/UA==
X-Gm-Message-State: AOJu0YwRFS00BySyNnQjvetD63Xqlmu5SGPBjRllvxmbf/rDPPOCuMTg
	5Zvob3P1TRLOtHoZiPavI8k=
X-Google-Smtp-Source: AGHT+IE1wCNOCDyBfA+lfQeQMkhdV6wxcRBF67BqLTCCouS/jdC6HIKQhCS2c72h9YUe34XOgJyQAA==
X-Received: by 2002:a05:600c:b41:b0:3f7:f2d0:b904 with SMTP id k1-20020a05600c0b4100b003f7f2d0b904mr20453068wmr.8.1697097351420;
        Thu, 12 Oct 2023 00:55:51 -0700 (PDT)
Received: from localhost ([81.168.73.77])
        by smtp.gmail.com with ESMTPSA id v2-20020a1cf702000000b00405d9a950a2sm21186220wmh.28.2023.10.12.00.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 00:55:51 -0700 (PDT)
Date: Thu, 12 Oct 2023 08:55:50 +0100
From: Martin Habets <habetsm.xilinx@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, corbet@lwn.net, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, andrew@lunn.ch,
	jesse.brandeburg@intel.com, sd@queasysnail.net, horms@verge.net.au,
	przemyslaw.kitszel@intel.com, f.fainelli@gmail.com,
	jiri@resnulli.us, ecree.xilinx@gmail.com
Subject: Re: [PATCH net-next v2] docs: try to encourage (netdev?) reviewers
Message-ID: <20231012075438.GA154637@gmail.com>
Mail-Followup-To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	corbet@lwn.net, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, andrew@lunn.ch,
	jesse.brandeburg@intel.com, sd@queasysnail.net, horms@verge.net.au,
	przemyslaw.kitszel@intel.com, f.fainelli@gmail.com,
	jiri@resnulli.us, ecree.xilinx@gmail.com
References: <20231011024224.161282-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011024224.161282-1-kuba@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 07:42:24PM -0700, Jakub Kicinski wrote:
> Add a section to netdev maintainer doc encouraging reviewers
> to chime in on the mailing list.
> 
> The questions about "when is it okay to share feedback"
> keep coming up (most recently at netconf) and the answer
> is "pretty much always".
> 
> Extend the section of 7.AdvancedTopics.rst which deals
> with reviews a little bit to add stuff we had been recommending
> locally.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>

> --
> v2:
>  - grammar fixes from Donald
>  - remove parenthesis around a quote
> v1: https://lore.kernel.org/all/20231009225637.3785359-1-kuba@kernel.org/
>  - spelling (compliment)
>  - move to common docs:
>    - ask for more opinions
>    - use of tags
>    - compliments
>  - ask less experienced reviewers to avoid style comments
>    (using Florian's wording)
> 
> CC: andrew@lunn.ch
> CC: jesse.brandeburg@intel.com
> CC: sd@queasysnail.net
> CC: horms@verge.net.au
> CC: przemyslaw.kitszel@intel.com
> CC: f.fainelli@gmail.com
> CC: jiri@resnulli.us
> CC: ecree.xilinx@gmail.com
> ---
>  Documentation/process/7.AdvancedTopics.rst  | 18 ++++++++++++++++++
>  Documentation/process/maintainer-netdev.rst | 15 +++++++++++++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/Documentation/process/7.AdvancedTopics.rst b/Documentation/process/7.AdvancedTopics.rst
> index bf7cbfb4caa5..43291704338e 100644
> --- a/Documentation/process/7.AdvancedTopics.rst
> +++ b/Documentation/process/7.AdvancedTopics.rst
> @@ -146,6 +146,7 @@ pull.  The git request-pull command can be helpful in this regard; it will
>  format the request as other developers expect, and will also check to be
>  sure that you have remembered to push those changes to the public server.
>  
> +.. _development_advancedtopics_reviews:
>  
>  Reviewing patches
>  -----------------
> @@ -167,6 +168,12 @@ comments as questions rather than criticisms.  Asking "how does the lock
>  get released in this path?" will always work better than stating "the
>  locking here is wrong."
>  
> +Another technique that is useful in case of a disagreement is to ask for others
> +to chime in. If a discussion reaches a stalemate after a few exchanges,
> +then call for opinions of other reviewers or maintainers. Often those in
> +agreement with a reviewer remain silent unless called upon.
> +The opinion of multiple people carries exponentially more weight.
> +
>  Different developers will review code from different points of view.  Some
>  are mostly concerned with coding style and whether code lines have trailing
>  white space.  Others will focus primarily on whether the change implemented
> @@ -176,3 +183,14 @@ security issues, duplication of code found elsewhere, adequate
>  documentation, adverse effects on performance, user-space ABI changes, etc.
>  All types of review, if they lead to better code going into the kernel, are
>  welcome and worthwhile.
> +
> +There is no strict requirement to use specific tags like ``Reviewed-by``.
> +In fact reviews in plain English are more informative and encouraged
> +even when a tag is provided, e.g. "I looked at aspects A, B and C of this
> +submission and it looks good to me."
> +Some form of a review message or reply is obviously necessary otherwise
> +maintainers will not know that the reviewer has looked at the patch at all!
> +
> +Last but not least patch review may become a negative process, focused
> +on pointing out problems. Please throw in a compliment once in a while,
> +particularly for newbies!
> diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
> index 09dcf6377c27..7feacc20835e 100644
> --- a/Documentation/process/maintainer-netdev.rst
> +++ b/Documentation/process/maintainer-netdev.rst
> @@ -441,6 +441,21 @@ in a way which would break what would normally be considered uAPI.
>  new ``netdevsim`` features must be accompanied by selftests under
>  ``tools/testing/selftests/``.
>  
> +Reviewer guidance
> +-----------------
> +
> +Reviewing other people's patches on the list is highly encouraged,
> +regardless of the level of expertise. For general guidance and
> +helpful tips please see :ref:`development_advancedtopics_reviews`.
> +
> +It's safe to assume that netdev maintainers know the community and the level
> +of expertise of the reviewers. The reviewers should not be concerned about
> +their comments impeding or derailing the patch flow.
> +
> +Less experienced reviewers are highly encouraged to do more in-depth
> +review of submissions and not focus exclusively on trivial or subjective
> +matters like code formatting, tags etc.
> +
>  Testimonials / feedback
>  -----------------------
>  
> -- 
> 2.41.0
> 

