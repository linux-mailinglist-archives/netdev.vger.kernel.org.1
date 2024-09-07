Return-Path: <netdev+bounces-126146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 051CA96FF06
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 03:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFD1E1F23890
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 01:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AC9B657;
	Sat,  7 Sep 2024 01:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avT61dkF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8D879C4
	for <netdev@vger.kernel.org>; Sat,  7 Sep 2024 01:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725673126; cv=none; b=VUmiQPCs2mtQk12LUWTVgTRHwGCHHQzxXI/h7jA6jQatQbLT/vED+a4Pe69U0jVYcCHX+sRAPFOxeebrXo9ogyeeIj6YYPi08zfDpXmvdxDxWV+wT/NXOq8lX4K4nV9TKOTON031vsYoz+4XWJCqfSHNb7IgdZG+9IzY5fBFt9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725673126; c=relaxed/simple;
	bh=ARwHwMy3pe+gBtBIzpiW8PvRiuhDUTnaPWoNjDOjmeY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ev9vn4w4/KJQlIWr2UtjyGOWGki/mTq1PTkqzUoh/pBFJoYGDLvyoCje1xaXsFEyYSFAjB+Mpu0g+F6p1O9Xc+DHrooFSTJ638Fv0wiwt4kb3TZ7vC8sWvKyoYhzX9h8jNHjwqrJwj9ObAd0Yjl1syZMeibQrj75aHbZh7RIkKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avT61dkF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23025C4CEC4;
	Sat,  7 Sep 2024 01:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725673125;
	bh=ARwHwMy3pe+gBtBIzpiW8PvRiuhDUTnaPWoNjDOjmeY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=avT61dkFLUNlMBtjF1r0dJ+U4ove5VsEEb0SmnzJdD+qDQDESfke+s3F8tFQ+2U1Q
	 Qsp/aAPpGnhmQXTF8beG514L4t2vbVJXQ+fkPPsn6DlAfiGwE1WdA4hVkk+aBYBAvl
	 rekDJvLvefHtXGmsOsyZEuxKHxlT3l2l9/zKCAUkQRVPsNDYT3khk/FDbHAWJk/9KM
	 MtE+J+4Af+njPanZpANc/d+siqIe0VGWSaqnc0cPLSTmr93JjaX9xcljI2C/bF3+Ci
	 XR+X3+vIEnm/d3tUXZEf2WYB9EBxP8PSW9oJKLkfcbaZgaX8z1eaMYjfskrFhS6yG3
	 cPAZ8ayC7QHcw==
Date: Fri, 6 Sep 2024 18:38:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 michael.chan@broadcom.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] bnxt_en: implement tcp-data-split ethtool
 command
Message-ID: <20240906183844.2e8226f3@kernel.org>
In-Reply-To: <20240906080750.1068983-1-ap420073@gmail.com>
References: <20240906080750.1068983-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  6 Sep 2024 08:07:48 +0000 Taehee Yoo wrote:
> The approach of this patch is to support the bnxt_en driver setting up
> enable/disable HDS explicitly, not rely on LRO/GRO, JUMBO.
> In addition, hds_threshold no longer follows rx-copybreak.
> By this patch, hds_threshold always be 0.

That may make sense for zero-copy use cases, where you want to make
sure that all of the data lands in target page pool. But in general
using the data buffers  may waste quite a bit of memory, and PCIe bus
bandwidth (two small transfers instead of one medium size).

I think we should add a user-controlled setting in ethtool -g for
hds-threshold.

Also please make sure you describe the level of testing you have done
in the commit message. I remember discussing this a few years back
and at that time HDS was tied to GRO for bnxt at the FW level.
A lot has changed since but please describe what you tested..
-- 
pw-bot: cr

