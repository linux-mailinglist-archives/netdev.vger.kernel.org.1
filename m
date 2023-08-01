Return-Path: <netdev+bounces-23072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D8D76A97F
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 08:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DEA91C20D3E
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 06:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977B4611E;
	Tue,  1 Aug 2023 06:49:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC8B610E
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 06:49:50 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367EB129
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 23:49:49 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5217ad95029so7111756a12.2
        for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 23:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1690872588; x=1691477388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nqm4iPRT+D61JMIQF9X+qCfMZswHJrAE6gtj2w8/g/8=;
        b=Xg80ErYqttUEvyCaZu2RhBHqiJa/o0VMuz5+Eg/jfzKGTyRK30GT8xHA8uu9inD0Sp
         xvQatC3WbHxfCHj27B/6GijVBhJJc1njFMqiRWT79ULFxsUWEK2rvqZsrFaK7ggEdkPL
         5egmRvLT16hseDoWmkxOria+8CUnse88SPZIz9h5Pw+GKf70xgNghSZsyM1eT04vNrzp
         BADPbdMcrv6L6NahqPGNWiZcAEbqFpEWDnkvNm1w2tFJFjF9T7/DLnuzBh9pVnSXZ3sT
         ZKf+iP/Ir7yDs8Rh9yr6l/Mc+OO+x79bjUM2JPylQUB/e0DEqiGwrk7wk1cjmaiP10C/
         Nilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690872588; x=1691477388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nqm4iPRT+D61JMIQF9X+qCfMZswHJrAE6gtj2w8/g/8=;
        b=O2R6qCVzLcGeGXlg3ss0YWi7aHe643FZhN4Ohq5h9hzHCNNemaRCbOAweNCeFyt9Xd
         IRgaA80+FaEiUap/G1T6sF51eBGsIV+231zKrW1dqExVaQhcz1DLwRnbiBdDPq5pen6U
         fI1iyYKNHIGj6yXF6PGlxtbMieqj0+lI4FLp4KaE7NwqBHRSAcIImI8poeLUFKDY0Fxh
         iI+g6MFGCA9c8L9s/iPqu3fNcBfJLHvDudsUYHknEhrfNoGjrTGFuk4/Acek8Ki4/Dvk
         b0uzFX9ZAndq7tZu9wqfYfHTrkqk8bgQnvufiJ55Oq75S6vk6/U+CYkNWwga39VZ0rBA
         ZJnA==
X-Gm-Message-State: ABy/qLa+JVnq1fvnHen0Yhz8jgwIfvQcKfq1UaKpYKVwJSMIvr4wt7YK
	sNVBM0DCxIlyzKAvrM+C5hQ7iQ==
X-Google-Smtp-Source: APBJJlFc4xjhN3+tLdAndQVBY60C4nOBD2HrUFkVQAKiF6nXh3wVI7s8E/CiQHOQA7R/Es5kbXCh1Q==
X-Received: by 2002:a17:906:2081:b0:997:eae6:9350 with SMTP id 1-20020a170906208100b00997eae69350mr1800446ejq.51.1690872587770;
        Mon, 31 Jul 2023 23:49:47 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id mb5-20020a170906eb0500b00997cce73cc7sm7154356ejb.29.2023.07.31.23.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 23:49:47 -0700 (PDT)
Date: Tue, 1 Aug 2023 08:49:45 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, moshe@nvidia.com, saeedm@nvidia.com,
	idosch@nvidia.com, petrm@nvidia.com
Subject: Re: [patch net-next v2 11/11] devlink: extend health reporter dump
 selector by port index
Message-ID: <ZMirCXLlY6H2yVEq@nanopsycho>
References: <20230720121829.566974-1-jiri@resnulli.us>
 <20230720121829.566974-12-jiri@resnulli.us>
 <20230725114803.78e1ae00@kernel.org>
 <ZMeunKZscNRQTssp@nanopsycho>
 <20230731100632.02c02b76@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731100632.02c02b76@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Mon, Jul 31, 2023 at 07:06:32PM CEST, kuba@kernel.org wrote:
>On Mon, 31 Jul 2023 14:52:44 +0200 Jiri Pirko wrote:
>> >This patch is not very clean. IMHO implementing the filters by skipping
>> >is not going to scale to reasonably complex filters. Isn't it better to  
>> 
>> I'm not sure what do you mean by skipping? There is not skipping. In
>> case PORT_INDEX is passed in the selector, only that specific port is
>> processed. No scale issues I see. Am I missing something?
>> 
>> 
>> >add a .filter callback which will look at the about-to-be-dumped object
>> >and return true/false on whether it should be dumped?  
>> 
>> No, that would not scale. Passing the selector attrs to the dump
>> callback it better, as the dump callback according to the attrs can
>> reach only what is needed, knowing the internals. But perhaps I don't
>> understand correctly your suggestion.
>
>for_each_obj() {
>	if (obj_dump_filtered(obj, dump_info))  // < run filter
>		continue;                       // < skip object
>
>	dump_one(obj)

I don't see how this would help. For example, passing PORT_INDEX, I know
exactly what object to reach, according to this PORT_INDEX. Why to
iterate over all of them and try the filter? Does not make sense to me.

Maybe we are each understanding this feature differently. This is about
passing keys which index the objects. It is always devlink handle,
sometimes port index and I see another example in shared buffer index.
That's about it. Basically user passes partial tuple of indexes.
Example:
devlink port show
the key is: bus_name/dev_name/port_index
user passes bus_name/dev_name, this is the selector, a partial key.

The sophisticated filtering is not a focus of this patchset. User can do
it putting bpf filter on the netlink socket.

