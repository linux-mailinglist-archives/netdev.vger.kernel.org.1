Return-Path: <netdev+bounces-32021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 406FF79215E
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 11:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D73331C20908
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 09:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC76F63B5;
	Tue,  5 Sep 2023 09:18:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C14663A7
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 09:18:10 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D3FBDD
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 02:18:09 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fef56f7248so22663055e9.3
        for <netdev@vger.kernel.org>; Tue, 05 Sep 2023 02:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693905487; x=1694510287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+f/34xL4509tmCMOHOJaLbB6o2+MQeuh0A3vjS1emho=;
        b=atBi4EfV2sBQp3f8832ApGpOkqL+sV9qW8HXn6R+HxhlJK3ZViEmiexk9aVje+35fh
         XcykB6mpvqI9dLclgNhhvfGE83abIHRLpZmpMgK/c31oGaXbxkbMzhhffiNHjP2bp52j
         l6rGqCd+d9T3t8GEe8836AAtOjgsGjQ6RFRtN98tJTPtPGmbKK6iZ4puDsYtjI86u2OC
         E7RLP4Y20bHFi0vzkKLFBG0TC2JjWyNLy/IBELyk2xJYVXBmUehMfQXtFmHW5yryEkc9
         xqh1iaWgDxnmfipNsJRcOYv4HsYcxCba8lEL6jBTbj44CJDMZFznz1HelCVVMtlTtZVC
         EXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693905487; x=1694510287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+f/34xL4509tmCMOHOJaLbB6o2+MQeuh0A3vjS1emho=;
        b=HoMb0qKbhNtrb2eOkiXJhzi0hDId8b/Ye2Fg4xqiOSIpOf/xB/e8SWQLl9px7P+cAj
         jr8RnpNmT4YSIaeioSNNnff7ZPhAEbB4MHRLCmrwrYUdsY8eCfQPl80bwpUdIE61qVd4
         Qn/TkUSIbAr8hoazsGHjr/z5SGnsAypDHqex3r1en/Tm5XjpnpB15UAOA38Abaq3OjrL
         10E8wSUtHz0VhZfBZ873/HP6sU+yid4FVbTNNsnzfu/oRGUZF784uRM+xMvcnTY7a/0+
         j/5DdmMp1805thApUe2v3mzjI5DA9LGH+9bNjro35FK+cgXq9TkVqEp/tj+mbGZ/cLvl
         Qtxw==
X-Gm-Message-State: AOJu0YwGxp7irR5ICQcF/lWtVRy4XjdkWYjE+JyOVFIrZ3pFSnyJpNjA
	OqEVABRXgu55v/GyfjTKlKmIrOePeBXFzZFVWwM=
X-Google-Smtp-Source: AGHT+IHH9jpCWYxNpePnrwZHsdEGi2mdGsBk5wiS8QXgAmYEIGDvnCW8GOnCZDQK04PbuRR8HpJrDg==
X-Received: by 2002:a05:600c:21d2:b0:3fe:2b76:3d7 with SMTP id x18-20020a05600c21d200b003fe2b7603d7mr8615998wmj.10.1693905487564;
        Tue, 05 Sep 2023 02:18:07 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l7-20020a1c7907000000b003fed8e12d62sm16359042wme.27.2023.09.05.02.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 02:18:07 -0700 (PDT)
Date: Tue, 5 Sep 2023 12:18:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Simon Horman <horms@kernel.org>,
	Linux Kernel Network Developers <netdev@vger.kernel.org>
Subject: Re: Weird sparse error WAS( [PATCH net-next v2 3/3] net/sched:
 act_blockcast: Introduce blockcast tc action
Message-ID: <e4de8720-e4bb-477d-ad80-55c8060cba2e@kadam.mountain>
References: <20230819163515.2266246-1-victor@mojatatu.com>
 <20230819163515.2266246-4-victor@mojatatu.com>
 <CAM0EoMnXUSkE2XjWusrkUgyQqaokT8BEnt+9_cAeNMXa8fd61w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM0EoMnXUSkE2XjWusrkUgyQqaokT8BEnt+9_cAeNMXa8fd61w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 24, 2023 at 10:30:18AM -0400, Jamal Hadi Salim wrote:
> Dan/Simon,
> Can someone help explain this error on the code below:
> 
> ../net/sched/act_blockcast.c:213:9: warning: context imbalance in
> 'tcf_blockcast_init' - different lock contexts for basic block
> 
> Looks like a false positive ...

I maintain Smatch and not Sparse.  It is a false positive.  Smatch will
parse that code correctly.  ;)

regards,
dan carpenter


