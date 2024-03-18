Return-Path: <netdev+bounces-80402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C186E87E9F8
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 14:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61A0FB224B4
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 13:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4914084B;
	Mon, 18 Mar 2024 13:18:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2133DBBF
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 13:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710767914; cv=none; b=LWamjCQkJ++TA64v0aZFMUd/4kxYXCNfH1WdLvRJigpbJquXEwadoTGjV5uKW2v3NtQ4pDOgsuTeK6tmiPcwzeWdWROoqVkWoDnlHe2ik8gdqT7bbsNo3zOLald2S6ba9y2iM1yzs+0rPUxzDOUf6MrJJCwJVzXSYvbcgKIL6zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710767914; c=relaxed/simple;
	bh=zctEPVPrmyLwap/RgQgUq9C4DmR1jI/04X6W6u7Yq7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUKqTs4hBhCnReJ5z2djSZkrF1ZfN1iBmb2QPjxbejR4lUneigAsHM5rN9LiWfNf1h3B/LqeH89747FCJvyhn9uLM9vVFXMtW1zrwdecvWmYeOg0pq7AhXH8tLece9oVlkB1TUxRJFExa/nNUlDj0YzNpcKKtRI/B36X3gkqEEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1rmCsg-0006Qq-Ee; Mon, 18 Mar 2024 14:18:22 +0100
Date: Mon, 18 Mar 2024 15:10:25 +0100
From: Florian Westphal <fw@strlen.de>
To: Lynne <dev@lynne.ee>
Cc: Netdev <netdev@vger.kernel.org>, Kuniyu <kuniyu@amazon.com>,
	Willemdebruijn Kernel <willemdebruijn.kernel@gmail.com>
Subject: Re: Regarding UDP-Lite deprecation and removal
Message-ID: <ZfhLUb_b_szay3GG@strlen.de>
References: <Nt8pHPQ--B-9@lynne.ee>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Nt8pHPQ--B-9@lynne.ee>

Lynne <dev@lynne.ee> wrote:
> UDP-Lite was scheduled to be removed in 2025 in commit
> be28c14ac8bbe1ff due to a lack of real-world users, and
> a long-outstanding security bug being left undiscovered.
> 
> I would like to open a discussion to perhaps either avoid this,
> or delay it, conditionally.

Is there any evidence UDP-Lite works in practice?

I am not aware of any HW that will peek into L3/L4 payload to figure out
that the 'udplite' payload should be passed up even though it has bad csum.

So, AFAIU L2 FCS/CRC essentially renders entire 'partial csum' premise moot,
stack will never receive udplite frames that are damaged.

Did things change?

