Return-Path: <netdev+bounces-57924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7DF8147F1
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 13:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF039B20BE7
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 12:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4DB2C690;
	Fri, 15 Dec 2023 12:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="yX3FI/JZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470BA2C68A
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 12:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40c41b43e1eso6899425e9.1
        for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 04:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1702642967; x=1703247767; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FN+6GvvrUZvDM7PrumZhDfORffhkx/he1rsNdPj/huk=;
        b=yX3FI/JZh4vzj/9HOqvNQ0ZNj7Ike1DYzWYrFlLik5UyANQfefZoSRdMW4TYE0v7N+
         Uki1KmorofQQMce7sBdJUACUWwxmNa3V/3hsLFIpokXdEcjNopQg+cEhYH7wFN/n7lA+
         27lBoGohPd3z07MTeOAFGVkleCCd/qatwdh/a1M+x9gxWJiBw16gWLtbIRcCKj/cs/Os
         afcu7AItDsLzYN7BvST76YrfIqTvtbiLfKjJCL+C1aOj11It+fMKDMB/J7m2HAxTT+rV
         6GWCyVjB2bz6MzvagjP93oz9bVoGgOo3SNa0k7jV0LZYd6YY6g/DAS5xIH5MYZNmR8fI
         ql2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702642967; x=1703247767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FN+6GvvrUZvDM7PrumZhDfORffhkx/he1rsNdPj/huk=;
        b=qg8QWY3/OD72XFC0y+qcaG9f5zMcntSpMW4lHVFdJbZvV1cg0wIpCkgvI3SeKfYFkZ
         4qHpf5t0a+axa4YB7enOLOsd0xZWVCllF/WmdRXL1+wCU7m3dhMG7z+OrlkpWDePyev1
         JhCqw8WvurRJVOojWSipnkbWWK0P6AUwNZik/iaJ3eF3Bu0giCk+O966EEzwSkPBPm9V
         0Uy9/fHC0CXLMy6/AcG0DlN4j0gnkkzBkXXBTt2Q9WIlLnWgEjqXEXpauY9pnRQBsvKf
         JhumZWvdipETmm+nq1fm3kZtRllR0d1qL60Bdf+jTsi8Db68s6xzpVRBzdSspYkG9pKZ
         qAXA==
X-Gm-Message-State: AOJu0YwOhzn0HzNMl2QraA4f6d+07XLJXnZWd3Aoa682sk7qn+rD7V1E
	8Q6MLc9NEBv+rgTfL+n2K4/zBQ==
X-Google-Smtp-Source: AGHT+IHPTOXz858Q7MyMBpsaIk+jCj79ALm/BDWRRrqWoDeyU8iyU3Cws+ZJKqKmnhoz8XfNrS1+4w==
X-Received: by 2002:a05:600c:2051:b0:40c:6924:5f2d with SMTP id p17-20020a05600c205100b0040c69245f2dmr752061wmg.231.1702642967155;
        Fri, 15 Dec 2023 04:22:47 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id n18-20020a05600c501200b0040b37f1079dsm31504681wmr.29.2023.12.15.04.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 04:22:46 -0800 (PST)
Date: Fri, 15 Dec 2023 13:22:45 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, intel-wired-lan@lists.osuosl.org,
	qi.z.zhang@intel.com, Wenjun Wu <wenjun1.wu@intel.com>,
	maxtram95@gmail.com, "Chittim, Madhu" <madhu.chittim@intel.com>,
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
	Simon Horman <simon.horman@redhat.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 0/5] iavf: Add devlink and
 devlink rate support'
Message-ID: <ZXxFFU021-urYrUS@nanopsycho>
References: <ZOcBEt59zHW9qHhT@nanopsycho>
 <5aed9b87-28f8-f0b0-67c4-346e1d8f762c@intel.com>
 <bdb0137a-b735-41d9-9fea-38b238db0305@intel.com>
 <20231118084843.70c344d9@kernel.org>
 <3d60fabf-7edf-47a2-9b95-29b0d9b9e236@intel.com>
 <20231122192201.245a0797@kernel.org>
 <e662dca5-84e4-4f7b-bfa3-50bce30c697c@intel.com>
 <20231127174329.6dffea07@kernel.org>
 <55e51b97c29894ebe61184ab94f7e3d8486e083a.camel@redhat.com>
 <20231214174604.1ca4c30d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214174604.1ca4c30d@kernel.org>

Fri, Dec 15, 2023 at 02:46:04AM CET, kuba@kernel.org wrote:
>On Thu, 14 Dec 2023 21:29:51 +0100 Paolo Abeni wrote:
>> Together with Simon, I spent some time on the above. We think the
>> ndo_setup_tc(TC_SETUP_QDISC_TBF) hook could be used as common basis for
>> this offloads, with some small extensions (adding a 'max_rate' param,
>> too).
>
>uAPI aside, why would we use ndo_setup_tc(TC_SETUP_QDISC_TBF)
>to implement common basis?
>
>Is it not cleaner to have a separate driver API, with its ops
>and capabilities?
>
>> The idea would be:
>> - 'fixing' sch_btf so that the s/w path became a no-op when h/w offload
>> is enabled
>> - extend sch_btf to support max rate
>> - do the relevant ice implementation
>> - ndo_set_tx_maxrate could be replaced with the mentioned ndo call (the
>> latter interface is a strict super-set of former)
>> - ndo_set_vf_rate could also be replaced with the mentioned ndo call
>> (with another small extension to the offload data)
>> 
>> I think mqprio deserves it's own separate offload interface, as it
>> covers multiple tasks other than shaping (grouping queues and mapping
>> priority to classes)
>> 
>> In the long run we could have a generic implementation of the
>> ndo_setup_tc(TC_SETUP_QDISC_TBF) in term of devlink rate adding a
>> generic way to fetch the devlink_port instance corresponding to the
>> given netdev and mapping the TBF features to the devlink_rate API.
>> 
>> Not starting this due to what Jiri mentioned [1].
>
>Jiri, AFAIU, is against using devlink rate *uAPI* to configure network
>rate limiting. That's separate from the internal representation.

Devlink rate was introduced for configuring port functions that are
connected to eswitch port. I don't see any reason to extend it for
configuration of netdev on the host. We have netdev instance and other
means to do it.


