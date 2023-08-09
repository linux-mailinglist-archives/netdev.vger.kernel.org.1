Return-Path: <netdev+bounces-25970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76708776501
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 18:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FF8D281CEE
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 16:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DCE1C9F2;
	Wed,  9 Aug 2023 16:27:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C65B18AE4
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 16:27:32 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42A71724
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 09:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SGH/jRgNmxazBBXdlh9QdP9iNHVohRSr1EERz3vqsYI=; b=UWiZQA2VTNk0n2aID8MbZUXCKS
	PdJR/m5bDUR16wNbIJOteWciWPHUI0OXz7YfI97kp1uJr5ViKR27vrEcFbWJK7l/guymIKmDGefKG
	zzxR9SWOh9KAMulOJyJX3F0CogAd+S3dcnz1JmZUqMquxpwfCgTetodIgaehdGTfmR+4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qTm1x-003bBk-H4; Wed, 09 Aug 2023 18:27:29 +0200
Date: Wed, 9 Aug 2023 18:27:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: netdev <netdev@vger.kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Simon Horman <simon.horman@corigine.com>,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH net-next v3 0/4] Support offload LED blinking to PHY.
Message-ID: <bd83fb99-abdd-4b4d-b6b6-6b8cef9fc22f@lunn.ch>
References: <20230808210436.838995-1-andrew@lunn.ch>
 <ZNO6hfjrJthoIUi9@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNO6hfjrJthoIUi9@makrotopia.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Overall I believe this is good to go, however, what remains
> unresolved is the chicken-egg when assigning the 'netdev' trigger
> using linux,default-trigger in device tree:

Agreed. This is pretty high up my TODO list to look at.

Thanks for the tested-by.

	Andrew

