Return-Path: <netdev+bounces-123207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8579641E0
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 12:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F5231C24556
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 10:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804841917D6;
	Thu, 29 Aug 2024 10:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xwwb767x"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBE718C002
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 10:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724927060; cv=none; b=ldmv+90TZyKHKQaOu/ZMG6X8NeDO37H8UVz9RCv+6ySiTaP4vWXWjVC+y9nIbKtFhAf94cpQRd8vipaZa1Appc1Lh5Ej1l8Cue5EvrIF5YrI5d7fGyfqco215qpphRcoXN82s0ChBcMYOl2m777QkzusaXSd8IDYFw2GLPjMDFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724927060; c=relaxed/simple;
	bh=NoeRe34j0Ka3WTELe4Hy022c42G+UofbdOueHrshp6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Db7zoooK+bLg8kiLGDr8krQSD7F7RQgE3gAKwRdrv8DVzvyVOb3fRF/D/h9Sumn9vcPMGw9adtbykZKIgKSG9hQVEh1gY2qw9yGTpfyhjrKoXdWLUlJFIM3msoFZMboNhVpc7DhB6tZWwTimTAyKNAeKXOZR9Aa9krh6g3OEcjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xwwb767x; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e2c94e22-371c-4b8b-9f5f-39bc72f58f39@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724927055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=unym3a76Nhh37H3Zp1rWwQ8dE6I6PPuOlzJH0Gaajg4=;
	b=xwwb767xOb/aqOldojPbUC7r5Qt/Fg62vgDqJNxGkYWMw838p9lX1VVl0ZqJ9aEmD4jWsy
	CPypq3oe3RMhsnr+dCjrUye7n0w2irPhHbxjlU5UUv4BW/8AEAkUa4sLq2K14wbzwbhBCG
	STipiVJgg0k3pfh3PGlwMAFawd14Rfk=
Date: Thu, 29 Aug 2024 11:24:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v6 0/3] ptp: ocp: fix serial port information export
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jonathan Lemon <jonathan.lemon@gmail.com>,
 Jiri Slaby <jirislaby@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, netdev@vger.kernel.org
References: <20240828181219.3965579-1-vadfed@meta.com>
 <20240828191509.51fe680a@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240828191509.51fe680a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 29/08/2024 03:15, Jakub Kicinski wrote:
> On Wed, 28 Aug 2024 11:12:16 -0700 Vadim Fedorenko wrote:
>> Starting v6.8 the serial port subsystem changed the hierarchy of devices
>> and symlinks are not working anymore. Previous discussion made it clear
>> that the idea of symlinks for tty devices was wrong by design [1].
>> This series implements additional attributes to expose the information
>> and removes symlinks for tty devices.
> 
> Doesn't apply now :(
> 
> Applying: ptp: ocp: convert serial ports to array
> Applying: ptp: ocp: adjust sysfs entries to expose tty information
> error: sha1 information is lacking or useless (drivers/ptp/ptp_ocp.c).
> error: could not build fake ancestor
> Patch failed at 0002 ptp: ocp: adjust sysfs entries to expose tty information
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> hint: When you have resolved this problem, run "git am --continue".
> hint: If you prefer to skip this patch, run "git am --skip" instead.
> hint: To restore the original branch and stop patching, run "git am --abort".
> hint: Disable this message with "git config advice.mergeConflict false"

Ah, I found the reason. Will send v7 soon.

