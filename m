Return-Path: <netdev+bounces-28303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B17777EF71
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 05:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB5A31C20FEF
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 03:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EA736A;
	Thu, 17 Aug 2023 03:18:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B824638
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 03:18:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E49C433C7;
	Thu, 17 Aug 2023 03:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692242297;
	bh=i5UDWEST6Iodtn/RFBSq3TRb/25kRWUgxsnalcwMP8s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pyVZap/wkaI9ku8a6GySSBKjpB7GFAME2V7JaWykuEv0vn97ZfNF0hh4Srj+xcFv9
	 BOjHIzm+TF9x5J9XBzC9phrMRxsCe9t9eBRLl1ZTzk1bqNI9J+uYUJU1VaogbevVrm
	 LUkAIiHjsmEgvHGwVRPqNf7PGXTTJYRNsoW2iPBWrWxFuDBRloWxeH7oqc9oxWnLkX
	 nceoSH2UHWHaVne1bERgtq/J4O0eUSir1NY9SZDXIF/sKYLlYVwpXsPXNSzNRIS66y
	 AFzbRZcXd2lgdKBo9j/7c903EhDNBYCvpUNqf70yg/nzMaeN/C8x8ALi/ItF91g2dp
	 OsLJ/VOpPUoQA==
Date: Wed, 16 Aug 2023 20:18:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alfred Lee <l00g33k@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, sgarzare@redhat.com, AVKrasnov@sberdevices.ru
Subject: Re: [PATCH net v3] net: dsa: mv88e6xxx: Wait for EEPROM done before
 HW reset
Message-ID: <20230816201816.29bea470@kernel.org>
In-Reply-To: <20230815001323.24739-1-l00g33k@gmail.com>
References: <20230815001323.24739-1-l00g33k@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Aug 2023 17:13:23 -0700 Alfred Lee wrote:
> If the switch is reset during active EEPROM transactions, as in
> just after an SoC reset after power up, the I2C bus transaction
> may be cut short leaving the EEPROM internal I2C state machine
> in the wrong state.  When the switch is reset again, the bad
> state machine state may result in data being read from the wrong
> memory location causing the switch to enter unexpected mode
> rendering it inoperational.

I'll apply this instead of the v4:

https://lore.kernel.org/all/20230815220453.32035-1-l00g33k@gmail.com/

since you dropped Andrew's tag :( Please make sure you keep the tags
you were given.

