Return-Path: <netdev+bounces-230558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D86BEB1C6
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 19:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EAFFF4E57EF
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 17:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0896B30505F;
	Fri, 17 Oct 2025 17:44:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077C52F0C75;
	Fri, 17 Oct 2025 17:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760723063; cv=none; b=E47taxLUt8hGt/JN8X3inGggIxiOoNqhUxWy0vYWl0+r9/1gjzq/LLffyoks0VkqpSi+uiwdpLY/4LPkAWiD0Ub+6jodfhYyrg1WyBm9GtS/meoHMvv+exvazD5xQfox7ir5oOIEOJ/poJEYdslMFCASGKULZvM0A3wAIDkU8Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760723063; c=relaxed/simple;
	bh=zOgb7LJUZ5yzzlyma0JGql64a75UXGfMSsJax/IFZw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tH0Q0+PdbCLakBPJ5AtMdKxnarsS5aQSGYck7Zt6PrLSMKnODDZ8lBEuWb9uWrygR+Xr59DYZQjcNQEMWBloPNY13weF6/+kQvaZ3qAWfbEH0x77dofPkYbp4YGwtK6OIwJM7cnR8OOtpVQGmzjxoMZwEJsDWQOCU57D/TySFio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82B8D1595;
	Fri, 17 Oct 2025 10:44:13 -0700 (PDT)
Received: from bogus (unknown [10.57.37.36])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B5653F66E;
	Fri, 17 Oct 2025 10:44:19 -0700 (PDT)
Date: Fri, 17 Oct 2025 18:44:17 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Adam Young <admiyo@amperemail.onmicrosoft.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>,
	Adam Young <admiyo@os.amperecomputing.com>, netdev@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "mailbox/pcc: support mailbox management of the
 shared buffer"
Message-ID: <aPKAcY_eZpNgsM8n@bogus>
References: <20250926153311.2202648-1-sudeep.holla@arm.com>
 <20251016-swift-of-unmatched-luck-dfdebe@sudeepholla>
 <edad8768-b7e4-4dfb-a08f-f85bbc443eaa@amperemail.onmicrosoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <edad8768-b7e4-4dfb-a08f-f85bbc443eaa@amperemail.onmicrosoft.com>

On Fri, Oct 17, 2025 at 12:00:24PM -0400, Adam Young wrote:
> Sorry, thought I was clear in  ACKing it.  Yes, please revert.
> 

Thanks for confirming. One of the change has introduced race on my
system and it is clearly corrupting the response with the new command
payload.

-- 
Regards,
Sudeep

