Return-Path: <netdev+bounces-23534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3D876C608
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 09:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56FB028180F
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 07:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A45B1C08;
	Wed,  2 Aug 2023 07:02:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDC31FB3
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 07:02:35 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC4F10C1
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 00:02:33 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe0eb0ca75so10355705e87.2
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 00:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1690959752; x=1691564552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cgOdzisalacSxg9f54h9NNgc2I8j5Mgp5JlUQUftN5o=;
        b=YeYI0pHioGI6TywvOHC/+1ZkPlcWi6xji1DlYE7XKBVrD990cP11u1TkmiKPxSrqbI
         BkNN4SC6SpXGgwp8y7ideulaT0bhf5E08eZnUcswQ+VR5LvKtZoKSFDIkHEZFSy03o4F
         B7WJyReyaFCpdogXZ2Em9Fozuc6rqUz6nR+Zp95eAyuOVXcfp/wSRmG8Nj5hAKSKHhip
         J7cbj5NCoH7JXmb7dPo34mQR1EVAdec9vhvGIzFTRyzIBPCQIoT3G4FMHB2ze1qRIi7q
         vdRySonbNR6mb/VQbJ981Jc/2KDx8h1erO4yjZAlKchAhN766cmnJQ3WPXR/lwkuhHf6
         mweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690959752; x=1691564552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgOdzisalacSxg9f54h9NNgc2I8j5Mgp5JlUQUftN5o=;
        b=cBSbB6KI8+jK32nEciDtLMlfUMFpQ27tJWxbUdqBAyl7QLQr/EuvxYbrSYSXVf5PjS
         xts9I3Xr3zpSdYiiue4R+PUt9CwFdmIRsaLMsINUbFFHPoScvuFBadTD/Fvfsntf7ArC
         JH/B/r8tTXw2OaMCOk+EBDyB7YgZDVHIrkV14tAg28UVWXNE5zpQcNKQaFl44PkSO9IR
         Z4y7vkch0IW/TBJ1jWEyxbjVe57t8uCj48HRyaV/QzHBETzgOYKB6GkuWI1WSn5Wpo9/
         zYcJHlFiON1LYEgM3AN536Y9Y7baGvTQOYerNg+r76Y8n6VeoUbLuKJ0nyeFjNVuOVHG
         3akQ==
X-Gm-Message-State: ABy/qLbb2+ko8/nEy+NMiyqi8A/l9bRNGeiIWfXlFNd3IqODZlcjTTZL
	2/Pm5o/rHCsm7PYt2allAf9UVw==
X-Google-Smtp-Source: APBJJlFPudUuqEhbwM7IPvwo2VmeTaN5YXaq9tL94SJCe4NbEPi0aHrCTb0EQjeA1PflfuD8q4aOVw==
X-Received: by 2002:ac2:4ec9:0:b0:4fd:cfeb:4785 with SMTP id p9-20020ac24ec9000000b004fdcfeb4785mr3593275lfr.53.1690959751669;
        Wed, 02 Aug 2023 00:02:31 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id kf7-20020a17090776c700b009887f4e0291sm8586082ejc.27.2023.08.02.00.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 00:02:30 -0700 (PDT)
Date: Wed, 2 Aug 2023 09:02:29 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, moshe@nvidia.com, saeedm@nvidia.com,
	idosch@nvidia.com, petrm@nvidia.com
Subject: Re: [patch net-next v2 10/11] devlink: introduce dump selector attr
 and use it for per-instance dumps
Message-ID: <ZMn/he9LEorV97uy@nanopsycho>
References: <20230720121829.566974-1-jiri@resnulli.us>
 <20230720121829.566974-11-jiri@resnulli.us>
 <20230725114044.402450df@kernel.org>
 <ZMetTPCZ59rVLNyQ@nanopsycho>
 <20230731100341.4809a372@kernel.org>
 <ZMipQcNtycg6Zyaq@nanopsycho>
 <20230801085301.3501fbbb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801085301.3501fbbb@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Aug 01, 2023 at 05:53:01PM CEST, kuba@kernel.org wrote:
>On Tue, 1 Aug 2023 08:42:09 +0200 Jiri Pirko wrote:
>> >> >Also - do you know of any userspace which would pass garbage attrs 
>> >> >to the dumps? Do we really need to accept all attributes, or can
>> >> >we trim the dump policies to what's actually supported?    
>> >> 
>> >> That's what this patch is doing. It only accepts what the kernel
>> >> understands. It gives the object types (as for example health reporter)
>> >> option to extend the attr set to accept them into selectors as well, if
>> >> they know how to handle them.  
>> >
>> >I'm talking about the "outer" policy, the level at which
>> >DEVLINK_ATTR_DUMP_SELECTOR is defined.  
>> 
>> I don't follow :/ Could you please describe what exactly do you mean and
>> want to see? Thanks!
>
>It's a bit obscured by the macros, but AFAICT you pass
>devlink_nl_policy for the dumps, while the _only_ attribute
>the kernel will interpret is DEVLINK_ATTR_DUMP_SELECTOR
>and its insides.

True, you are correct.
Anyway with the split ops generation, this is going to be narrowed down,
so possiblem garbage is ignored.
Thanks!


