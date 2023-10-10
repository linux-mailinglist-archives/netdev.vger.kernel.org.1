Return-Path: <netdev+bounces-39470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1737BF642
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 10:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA19C281AA0
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 08:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB14D52B;
	Tue, 10 Oct 2023 08:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcQ4kWuN"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B095BA57
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 08:42:07 +0000 (UTC)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006AC9F;
	Tue, 10 Oct 2023 01:42:04 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-5068692b0d9so4557141e87.1;
        Tue, 10 Oct 2023 01:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696927323; x=1697532123; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ae0hLvXNfmj5oKuaaZeV8hEDEMUV8fln2sNtm/lezaY=;
        b=CcQ4kWuN5CVjt2Tq+9/wqmAZI/F/LD2b1b614J/10A00QocXx1OW7XIBh5b2173QWD
         14eCOXfuGRscZCAlI1dpbyCsLXQG775s0tHdCWsTOmxa4rkEW7224lQ75rwoPEqI2HaC
         8oeVwF2F17vFf+Lt9XhEs8ErJeqmPbsFikqEj4qx0wp0SR49MjN2w8I3nPzBlI1xz5kc
         ZZv6wbsDyUOQ9L7QGWBkyt4w0G4PnPmb2NLDttH4bMwIVwyci59HbuliUFqaAbjWz+OG
         BoQQBCtfHJh7xQFec3lv1D8xgfqbDckfxk2ZSC4DsBTlri4Qd4SntAXV/Dlksdf88KfV
         91wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696927323; x=1697532123;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ae0hLvXNfmj5oKuaaZeV8hEDEMUV8fln2sNtm/lezaY=;
        b=jcZX+Pk+gcJPYEceeIXZFjgozc9CPeLQ6vdOo4t5zTcl/ZF5t+9CuQkzMqZg5x7t47
         ujyPJV7kYtGo/Pm2gulSv/Tmj2A9aN2Mhw+8+EXZgyz1XxR2+RF/E3tsb8Y2pE6pKlUy
         Bc6li/7TUaeb0D94t0Ul5AYD8jKyguOXfuYwQzsUW80DcJv1Xq7KTVdo3cr36zGCNCr9
         jJYnSInqbXqUMVNsfJr/WxiJYvtZNBpAkQ+NDrWHoLNMxAV9oaRG1s7S0Evqwte2pyXB
         nPqOs3widBtLmD31pLpWiCjRwi+sD0IfJaLUVyOHMrqC8XpHrSRD3eRJ9NKX60vOAxs1
         pKxg==
X-Gm-Message-State: AOJu0Yxi0vguKDE3C1HMYWCAxpnlqIw3b0dbKpGKKb2Zu4Ikwn4UvQHg
	QBgza1xrX07MwdklSaTmaMeGapQ9WGXwwA==
X-Google-Smtp-Source: AGHT+IGP9iJh77kM89/iiAZsxIhGPSthdopuP0xLcB9rrdz2C3htcFrLq9rMqVW8tuFHPLGoDZM4Ng==
X-Received: by 2002:a19:8c5a:0:b0:504:7f2e:9391 with SMTP id i26-20020a198c5a000000b005047f2e9391mr13817096lfj.34.1696927322756;
        Tue, 10 Oct 2023 01:42:02 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:25e3:a83f:9563:f690])
        by smtp.gmail.com with ESMTPSA id k22-20020a7bc416000000b00404719b05b5sm13465447wmi.27.2023.10.10.01.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 01:42:01 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  corbet@lwn.net,  workflows@vger.kernel.org,
  linux-doc@vger.kernel.org,  andrew@lunn.ch,  jesse.brandeburg@intel.com,
  sd@queasysnail.net,  horms@verge.net.au,  przemyslaw.kitszel@intel.com,
  f.fainelli@gmail.com,  jiri@resnulli.us,  ecree.xilinx@gmail.com
Subject: Re: [PATCH net-next] docs: try to encourage (netdev?) reviewers
In-Reply-To: <20231009225637.3785359-1-kuba@kernel.org> (Jakub Kicinski's
	message of "Mon, 9 Oct 2023 15:56:36 -0700")
Date: Tue, 10 Oct 2023 09:41:33 +0100
Message-ID: <m27cnuoon6.fsf@gmail.com>
References: <20231009225637.3785359-1-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jakub Kicinski <kuba@kernel.org> writes:

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

I for one really appreciate this additional guidance and where better to
start than by reviewing the guidance for new reviewers :-)

Looks good other than some minor grammar nits below.

>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> --
> RFC -> v1:
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
> index bf7cbfb4caa5..415749feed17 100644
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
> +Another technique useful in case of a disagreement is to ask for others

Another technique that is useful ...

> +to chime in. If a discussion reaches a stalemate after a few exchanges,
> +calling for opinions of other reviewers or maintainers. Often those in

then call for

> +agreement with a reviewer remain silent unless called upon.
> +Opinion of multiple people carries exponentially more weight.

The opinion

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
> +even when a tag is provided (e.g. "I looked at aspects A, B and C of this
> +submission and it looks good to me.")
> +Some form of a review message / reply is obviously necessary otherwise

Minor nit but I think "or" would be preferable to "/" in prose like this.

> +maintainers will not know that the reviewer has looked at the patch at all!
> +
> +Last but not least patch review may become a negative process, focused
> +on pointing out problems. Please throw in a compliment once in a while,
> +particularly for newbies!
> diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
> index 09dcf6377c27..a0cb00e7f579 100644
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
> +review of submissions and not focus exclusively on trivial / subject

Do you mean subjective matters?

> +matters like code formatting, tags etc.
> +
>  Testimonials / feedback
>  -----------------------

