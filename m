Return-Path: <netdev+bounces-23274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE6876B764
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 16:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75EAC281A05
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 14:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B39B25146;
	Tue,  1 Aug 2023 14:27:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807D11E503
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 14:27:59 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63ABE9
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 07:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690900076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OiKp+DLs2E57ZGEaNGbdB/rs+kmLd3ZvL6l0s5JN5S0=;
	b=TavawkoJYfrjRKnu5JhYfmEGzQazRcvZQzwG62rP3w0+novw7Om8ioFwbrrVp5VFA7AfVr
	gbm2jn9D76aCpXFgPh3aUfzGNO4a9RLEjBi165yIkhK13S7lSf5lE+nYMeVrltGFgmpi+3
	r6UC8ECeRpWBYLkUqNCcoq7HJgCJWW8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-JKS9-hQSMzWTQqmVH2bUkQ-1; Tue, 01 Aug 2023 10:27:55 -0400
X-MC-Unique: JKS9-hQSMzWTQqmVH2bUkQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4fe3fb358easo1034069e87.2
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 07:27:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690900074; x=1691504874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OiKp+DLs2E57ZGEaNGbdB/rs+kmLd3ZvL6l0s5JN5S0=;
        b=cE116/ce0NdZ7xe4jMXEnjLFMtuiWXw6lBSr76hgs5b8JukjNzKr76xLOhtr5f3ccz
         2efBS+CAWdf1a+FsGBS+TfcHYDJw0q9ehfcaXLi5R0sNmaTpORl7iNYQvIcXnwRDDshH
         /Uo0gGxxNqP5LGSQmfRD6j5SlhHN09uj54u/Mq/3y4xcMFGM1cGy/CYTndKioYsmTdqn
         HjQIxID8ikY7w4wu1vklZhkwYBbSZtI0kEPMVNIFVLb6Kvhpqsc6OTOw8eqKS7FvdnPn
         /kn2nyGYPCpIPDAaoDjMmFlK4PNDU1xUi4HcZWbWa4vo23W5K4hTsVEzZbhTe1yQlj82
         /B5Q==
X-Gm-Message-State: ABy/qLaQIepnvhhYK0vsFsw/W3TJbs0xR+vdMc+0v9JJPohfvuBpXSWZ
	jU/paXnLCjIZt4XnuixTm/Z5HaakUtHJA50R2tTabFR2rinsFIoEQEtrOSZwFUCmGVc1xkmyTOe
	qhhV+uZf98EVCTM5pBHg6X019aKk=
X-Received: by 2002:a19:5f12:0:b0:4fb:8bfd:32e4 with SMTP id t18-20020a195f12000000b004fb8bfd32e4mr2163090lfb.13.1690900073791;
        Tue, 01 Aug 2023 07:27:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH6gVPESsk1l8r6O1U/WZ2Fhl+tvZOgDRCiTSrYCpXnj4G0+AhEfeImQ3zeruCo3lQuBaMlKw==
X-Received: by 2002:a19:5f12:0:b0:4fb:8bfd:32e4 with SMTP id t18-20020a195f12000000b004fb8bfd32e4mr2163080lfb.13.1690900073505;
        Tue, 01 Aug 2023 07:27:53 -0700 (PDT)
Received: from localhost ([81.56.90.2])
        by smtp.gmail.com with ESMTPSA id v16-20020a1cf710000000b003fc080acf68sm16992225wmh.34.2023.08.01.07.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 07:27:52 -0700 (PDT)
Date: Tue, 1 Aug 2023 16:27:52 +0200
From: Davide Caratti <dcaratti@redhat.com>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
	xiyou.wangcong@gmail.com, jiri@resnulli.us
Subject: Re: [RFC PATCH net-next 0/2] selftests/tc-testing: initial steps for
 parallel tdc
Message-ID: <ZMkWaHsVnNOo8xjc@dcaratti.users.ipa.redhat.com>
References: <20230728154059.1866057-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728154059.1866057-1-pctammela@mojatatu.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 28, 2023 at 12:40:57PM -0300, Pedro Tammela wrote:
> As the number of tdc tests is growing, so is our completion wall time.
> One of the ideas to improve this is to run tests in parallel, as they
> are self contained. Even though they will serialize over the rtnl lock,
> we expect it to give a nice boost.
> 
> A first step is to make each test independent of each other by
> localizing its resource usage. Today tdc shares everything, including
> veth / dummy interfaces and netns. In patch 1 we make all of these
> resources unique per test.
> 
> Patch 2 updates the tests to the new model, which also simplified some
> definitions and made them more concise and clearer.

hello, 

tests are ok!  A couple of (minor) items:

- the patched code introduces a dependency for python (must be > 3.8).
  That's ok, but maybe we should put this in clear in the commit message
  of patch 1/2.
- TEQL test passes, but the code doesn't look functional for namespaces:
  maybe we can keep teql test not requiring nsPlugin?

other than this, looks good to me, thanks!

Reviewed-and-tested-by: Davide Caratti <dcaratti@redhat.com>


