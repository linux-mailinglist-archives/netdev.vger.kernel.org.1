Return-Path: <netdev+bounces-108355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB8291F0F1
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 10:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1A7CB235C3
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 08:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CE914A62D;
	Tue,  2 Jul 2024 08:21:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F051474D3
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 08:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719908487; cv=none; b=FvbJPi1T7YAJl9FFY0wHgNDhZ6EgJO5HP4Pr3uhxzBZ3kMVBqgPG+RkPwxNE/vHxnporQDoLBzk8cLA8QdWcRwy0juA8YAgA5O0nW7P7V5/3LL4h6U7xkg/YHwWj01hVJdMwLPC4k2iKDe2obWrFOvZeDaTKx31IkcOqBnN5MA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719908487; c=relaxed/simple;
	bh=NvIWby6GIxAu/RZMWcVIOnGoICNi8/pLzyeipWP6v34=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=WA3na/kTqfP/EAZ1lr3foQrjqWHxWiJt358GiLLHOJz2eLqDi9IUaVegcr5ndxdP3jvF4qCC1PaqzfjIqPRZ0cODuhVGw75rwkU03QzT24igLRVbL4uXW5+4Mkouqzd51EglwVPmuR5+XHOzUtCpPo4Xv5tInI7Dzdb215R4bzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <f.pfitzner@pengutronix.de>)
	id 1sOYlG-0000yN-RM; Tue, 02 Jul 2024 10:21:14 +0200
Message-ID: <fdb32bba-9576-4836-b013-8c07f07cf307@pengutronix.de>
Date: Tue, 2 Jul 2024 10:21:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: f.pfitzner@pengutronix.de
Cc: mkubecek@suse.cz, netdev@vger.kernel.org
References: <20240603114442.4099003-1-f.pfitzner@pengutronix.de>
Subject: Re: [PATCH ethtool 1/2]: add json support for base command
Content-Language: en-US, de-DE
From: Fabian Pfitzner <f.pfitzner@pengutronix.de>
In-Reply-To: <20240603114442.4099003-1-f.pfitzner@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: f.pfitzner@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

I have not gotten any response to my patches yet. Any feedback or 
information if it will get merged into upstream soon? Am I missing 
something?


