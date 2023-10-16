Return-Path: <netdev+bounces-41347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0309D7CAAB2
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 16:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3317B1C2089B
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 14:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC8828693;
	Mon, 16 Oct 2023 14:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RBV76PYq"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B7127EEF
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 14:01:27 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32667113
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 07:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697464885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uap3XnM9Lhyb19jxlmHwFpG/UglaDemto96MtQ/jYiA=;
	b=RBV76PYqRz6ojcWctJAoDOSCHFfXdWV6uw/tfWY83vf3Cw7B1rtqb0z8XlG670gZa0jMZg
	SjysNCq81wvLhzFQI1CyvZkKU/ETbAPOQQ0DVKtseF7oONu5qA8WEveCM59tgvYk8xdO3m
	PmTj0Y5DeJ2b5D4a7kKUYpkly10v0+A=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-QyfNANKjMk2NdrNPct7yjw-1; Mon, 16 Oct 2023 10:01:23 -0400
X-MC-Unique: QyfNANKjMk2NdrNPct7yjw-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7770bfcbdc6so566184385a.0
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 07:01:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697464879; x=1698069679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uap3XnM9Lhyb19jxlmHwFpG/UglaDemto96MtQ/jYiA=;
        b=IHaiLAxyxVkMiofCPM+IeAUpolSYkB+9yUC76HtrqCE2LRDssX/mMEzkiNTvSJznIJ
         SkjiUEwF5sFJKwXbXRvnCp+lZndTrTEzQxjuQhozwsw0620u7XVHZWeP0/gojBroRD16
         OxxvVfMe5056jR9obVnvehHPjjgBvhb+RfzKw++4NMkN1bqjJlG39TFdm8BpaCl5XJFM
         7iR6JTFOHLiXUq1uxYakK7vdcemJ6pj4eqw4k0UKBXjpdrW6ni+uwTM1nsCIP5pcUnCT
         4SyZOlkWm4pCRqP97ODs/3Ydtl32wQ4RCyuIrKF4ijJntzcplewOFEgY7h/f1OwWM8wF
         NxrA==
X-Gm-Message-State: AOJu0Yy25wA2ZrKI+QMJHwRJKyt+SiIjbfhxJEb7gjI9zJ88Tx/jKOiq
	lniWfk3SNWhki0K/G9gEt/vAqFIYvm1dilZrE1m8v1UIlAcRYUWL2Gyz7i/pXsLL0DN8SebPAhn
	MfF//wsXOsSv/cq3f
X-Received: by 2002:ac8:7e96:0:b0:405:37fd:be80 with SMTP id w22-20020ac87e96000000b0040537fdbe80mr45482917qtj.28.1697464879403;
        Mon, 16 Oct 2023 07:01:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEb10pK3UlPBDVZPZEa2itrsXkwXP+tUxZRGEufquB0c7etO9xrmo88reJKOBREiXqFQEH5lA==
X-Received: by 2002:ac8:7e96:0:b0:405:37fd:be80 with SMTP id w22-20020ac87e96000000b0040537fdbe80mr45482872qtj.28.1697464878959;
        Mon, 16 Oct 2023 07:01:18 -0700 (PDT)
Received: from localhost ([81.56.90.2])
        by smtp.gmail.com with ESMTPSA id l18-20020ac84592000000b0041b0b869511sm3036221qtn.65.2023.10.16.07.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 07:01:18 -0700 (PDT)
Date: Mon, 16 Oct 2023 16:01:15 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: jhs@mojatatu.com, daniel@iogearbox.net, xiyou.wangcong@gmail.com,
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, paulb@nvidia.com,
	bpf@vger.kernel.org, mleitner@redhat.com, martin.lau@linux.dev,
	netdev@vger.kernel.org, kernel@mojatatu.com
Subject: Re: [PATCH RFC net-next v2 1/1] net: sched: Disambiguate verdict
 from return code
Message-ID: <ZS1CK76Dkyoz6nZo@dcaratti.users.ipa.redhat.com>
References: <20231014180921.833820-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231014180921.833820-1-victor@mojatatu.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

hello Victor, thanks for the patch!

On Sat, Oct 14, 2023 at 03:09:21PM -0300, Victor Nogueira wrote:
> Currently there is no way to distinguish between an error and a
> classification verdict. Which has caused us a lot of pain with buggy qdiscs
> and syzkaller. This patch does 2 things - one is it disambiguates between
> an error and policy decisions. The reasons are added under the auspices of
> skb drop reason. We add the drop reason as a part of struct tcf_result.
> That way, tcf_classify can set a proper drop reason when it fails,
> and we keep the classification result as the tcf_classify's return value.
> 
> This patch also adds a variety of drop reasons which are more fine grained
> on why a packet was dropped by the TC classification action subsystem.
> 
> Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> ---
> 
> v1 -> v2:
> - Make tcf_classify set drop reason instead of verdict in struct
>   tcf_result
> - Make tcf_classify return verdict (as it was doing before)
> - Only initialise struct tcf_result in tc_run
> - Add new drop reasons specific to TC
> - Merged v1 patch with Daniel's patch (https://lore.kernel.org/bpf/20231013141722.21165ef3@kernel.org/T/)
>   for completeness

Acked-by: Davide Caratti <dcaratti@redhat.com>

By the way, this might be a chance to remove the "TC mirred to Houston"
printout and replace it with a proper drop reason (see [1]). WDYT?

thanks,
-- 
davide

[1] https://lore.kernel.org/netdev/Yt2CIl7iCoahCPoU@pop-os.localdomain/


