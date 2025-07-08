Return-Path: <netdev+bounces-204938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8F0AFC9AE
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 13:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7576656460D
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 11:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E15F21D587;
	Tue,  8 Jul 2025 11:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h8C4s/n3"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0B613633F
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 11:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751974339; cv=none; b=e12tBJ4hf6psGv9/O6LAlyq4/V/0h4A0Hepj0m9N27KzMtm2nqZXjfnL8Kq5wx6l5wm6/ztOOmCai5/JmLyQx6wb+TiKi0fdBbyGZBSGDFQzuYNAPxLYbsOom0r+U6LtFlyspZLgbrj9kXoWnww0M5gY0j4ozeaBISHvU0dUCOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751974339; c=relaxed/simple;
	bh=a2aQdzQGolo47nGWy87r7S4pemzwgOkADkTHecLWJY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YzgFgz0QY1KBH2QyJf7SxklqwdM64za00xPiRYaE1Umy3AOfFMSnIgSMpgqBDim+mZCEBPSRiePiYVNcB2zjdi1nfi9Zgma368UfS5/IVdNXf0IkbP3aTAZ/gA55Yvhd1cx3AYMNhCCDKYqg25Rg3jc+DvrKssrpQPOt39Hp6wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h8C4s/n3; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a879739a-0696-406a-8233-332a1fc20fc6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751974334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wwqie4p/S/JtpJQWuktif2U9BwaYBKcyNY2So4udb8k=;
	b=h8C4s/n3+dtWpLY+VHro0ibQuVi7ZeIWELFY0ol/ysXvob4aO//F/lGcrAiv7u8fRhS6yA
	zD2rfZZlcTThAhqiyrLx6Gge7LSNcTq0KQhY9IzwRx822yXMYr7etdGjjorVUSNeOrTXhT
	TZW3lkE+xC9Bi1zg6cS4tG1P6vCXYxY=
Date: Tue, 8 Jul 2025 12:32:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net-next] amd-xgbe: add ethtool counters for error and dropped
 packets
To: Raju Rangoju <Raju.Rangoju@amd.com>, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Shyam-sundar.S-k@amd.com
References: <20250708041041.56787-1-Raju.Rangoju@amd.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250708041041.56787-1-Raju.Rangoju@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 08/07/2025 05:10, Raju Rangoju wrote:
> add the ethtool counters for tx/rx dropped packets and tx/rx error
> packets
> 
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> ---

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>



