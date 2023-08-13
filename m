Return-Path: <netdev+bounces-27144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3E877A779
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 17:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5871E280F69
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 15:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4718979DF;
	Sun, 13 Aug 2023 15:32:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A82C846E
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 15:32:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681FBC433C8;
	Sun, 13 Aug 2023 15:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691940727;
	bh=pNzd0jPoK1/7tmEtl+sPzQlrbfYgD5Os2z+f6A1BXOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=girRRykMw3vifG+WNE8zFFej5rXPVMxrEVQE8l90xOEBEEhOJhRTcDvmWk1GDConx
	 BK0Ul3gXJFyEmsx0mis9goIEzI8rj6GgAw74cx1i+rQcnQpc8ETGYwTIsg2kYB72DV
	 TUsZ2JpnNjX6BuNb/mPNCy+8oXRXRlij/hVaT5s4/+CYTjvZfPzK5yGwRKRFsmMp1M
	 JXrxL2+K8j3TEzTfkvlK7OnBLdbyTiW4RBSiwraeUZrBhDTzs88d7uoVFUzhZ+0pa7
	 c9XEc+yXTOnRMeWM2tE7fcPV47ScVOsVNZo6hwREJUx+CtQhU9P2ezM0tk1Oe0xT1I
	 gcQj46AtvNpUg==
Date: Sun, 13 Aug 2023 17:32:03 +0200
From: Simon Horman <horms@kernel.org>
To: Alfred Lee <l00g33k@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, andrew@lunn.ch,
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, sgarzare@redhat.com,
	AVKrasnov@sberdevices.ru
Subject: Re: [PATCH v2 net] net: dsa: mv88e6xxx: Wait for EEPROM done before
 HW reset
Message-ID: <ZNj3c2TO6bqfe0IM@vergenet.net>
References: <20230811232832.24321-1-l00g33k@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811232832.24321-1-l00g33k@gmail.com>

On Fri, Aug 11, 2023 at 04:28:32PM -0700, Alfred Lee wrote:
> If the switch is reset during active EEPROM transactions, as in
> just after an SoC reset after power up, the I2C bus transaction
> may be cut short leaving the EEPROM internal I2C state machine
> in the wrong state.  When the switch is reset again, the bad
> state machine state may result in data being read from the wrong
> memory location causing the switch to enter unexpect mode

nit: unexpect -> unexpected

> rendering it inoperational.
> 
> Fixes: 8abbffd27ced ("net: dsa: mv88e6xxx: Wait for EEPROM done after HW reset")
> Signed-off-by: Alfred Lee <l00g33k@gmail.com>

