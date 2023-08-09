Return-Path: <netdev+bounces-25656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E21D775099
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 03:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBF7B1C2105B
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 01:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D1162C;
	Wed,  9 Aug 2023 01:55:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15369376
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 01:55:32 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2003FF3
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 18:55:32 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-686f94328a4so333277b3a.0
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 18:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691546131; x=1692150931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Swubk1OT5Fx4dunfrpDRgc78Asw5cZBLFh/l1DXxPv4=;
        b=WAsjtyUWXWxDbE3TEXolCN/0D1k0axKVbgXGqYcT+YPBWrnSfWMM5EsNyiWsjTPoz9
         /syhmQDSDNnVlG6SBm+gJTM56MRLfvih6rlG9ySXzTiIebKPjE1RNcI3eIZ5ufPl3mv5
         RWAnqJU13QroC0IrrKFf7KGJ8GL9pmFnB3o/fwgGU65tQCeeEiXO6WgtUA2P0U18/u9h
         LbzF6aShA6xtGRVdPGUcWj5PSth5yiIV46TI7W0uZzb0sbMwnKO9rGKZxC6NX5kqT+rb
         bYmvBVgPNFcsaxhfba2k1zKFsRMnlvgeZm00TU/6O04ujyUKtChrcYAvyU4gP/HECOtw
         otAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691546131; x=1692150931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Swubk1OT5Fx4dunfrpDRgc78Asw5cZBLFh/l1DXxPv4=;
        b=f5mpEHA5JTkGYTLJNe/ANfGY2wEgqaNP3A/hTiAhham3chgA/CidX6FZXds0rudDWB
         edIHMIys4xYdWFXoMLzTGQ0ZEem+OF4XhwW371N8nEuGV4hthdEExbDYuIaAJZSFsGND
         fF93dL9yjIfd+JPTm4JARK0CdRwq79yTyKRHDnzD7kISyYScxHB8e3QYOBpbLgn/+Thj
         pxh8KvKrjgW8BO0Af1CbqtD3s4/HKw7t21PIr1JZQdp8KYz8U3W4MY3rpELDliAduQ2c
         0X/YoPQ+nMJ1yd6UZ4wstrk6/70NsuOhq9QME01yDsqIOiUvmEOjjE5Ofxve0rpPXyL5
         zzOg==
X-Gm-Message-State: AOJu0YwroJkyUqtQBYjh6dwX7LblD5ln2f1erT/YAujI+Qm5H7uOIMF0
	GseuNbbJxB2mrxQV2vq9Dc8=
X-Google-Smtp-Source: AGHT+IE1pl2WiQh3yCDpu156ydhc4ZDyz2y5DGXlJhIlDrp2qaalPXUc68WYRstukqRzSdcfnvonMw==
X-Received: by 2002:a05:6a20:7fa6:b0:133:17f1:6436 with SMTP id d38-20020a056a207fa600b0013317f16436mr1978035pzj.19.1691546131358;
        Tue, 08 Aug 2023 18:55:31 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id h8-20020a62b408000000b00682ad3613eesm8739573pfn.51.2023.08.08.18.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 18:55:30 -0700 (PDT)
Date: Wed, 9 Aug 2023 09:55:25 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, petrm@nvidia.com,
	razor@blackwall.org, mirsad.todorovac@alu.unizg.hr
Subject: Re: [PATCH net v2 06/17] selftests: forwarding: Add a helper to skip
 test when using veth pairs
Message-ID: <ZNLyDT5X2GYQfqQR@Laptop-X1>
References: <20230808141503.4060661-1-idosch@nvidia.com>
 <20230808141503.4060661-7-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808141503.4060661-7-idosch@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 08, 2023 at 05:14:52PM +0300, Ido Schimmel wrote:
> A handful of tests require physical loopbacks to be used instead of veth
> pairs. Add a helper that these tests will invoke in order to be skipped
> when executed with veth pairs.

Hi Ido,

How to create physical loopbacks?

Thanks
Hangbin

