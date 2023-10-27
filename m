Return-Path: <netdev+bounces-44786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 128977D9D46
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 17:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42F341C21068
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 15:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB9537CBE;
	Fri, 27 Oct 2023 15:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHVngFVK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131C8D530;
	Fri, 27 Oct 2023 15:45:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790C9C433C9;
	Fri, 27 Oct 2023 15:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698421554;
	bh=M5cZ4Uk5UHS51pZo0cfXXopOOU+Ewc0rgIoSeP5TaS8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=QHVngFVKX3lB8qTUk2Fw3efNy3Ben7Jox1xQdQm0b/MiWSsT0Mhh4dkmNEyN6Bagu
	 RyjvJcJPVOe7BK+btaweQRm38BLBRJJcfYFZnbICGwXl+2gPbE3qKAjlRZlLbU7KoB
	 HOO1p3MfWqKmkx81fLsbHkDqu8OJQoViVlD2Iu0q/azbRwKqpxGvLf1SiT+V/mfyrm
	 2bbLrc08ejaoP1KmEWmMQp8v3n+bHBs/pEvq1z8yCoAGSB0I/IJ6qBEfHAxZtDrvFF
	 E4hiTj7cuXVwhMpbVvH0GOzQFRviTWPqfm3juuw/gM83AffbhjYfY/NHOGk0uykELi
	 W4SNIk1eDNN3A==
Date: Fri, 27 Oct 2023 08:45:53 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
cc: Matthieu Baerts <matttbe@kernel.org>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
    Geliang Tang <geliang.tang@suse.com>, 
    Kishen Maloor <kishen.maloor@intel.com>, netdev@vger.kernel.org, 
    mptcp@lists.linux.dev
Subject: Re: [PATCH net-next 03/10] mptcp: userspace pm send RM_ADDR for ID
 0
In-Reply-To: <20231027084324.42e434bb@kernel.org>
Message-ID: <9138af81-6312-9a96-076e-6b164285c34b@kernel.org>
References: <20231025-send-net-next-20231025-v1-0-db8f25f798eb@kernel.org> <20231025-send-net-next-20231025-v1-3-db8f25f798eb@kernel.org> <20231026202629.07ecc7a7@kernel.org> <aa71b888-e55b-a57d-28cc-f1a583e615f9@kernel.org>
 <20231027084324.42e434bb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 27 Oct 2023, Jakub Kicinski wrote:

> On Fri, 27 Oct 2023 08:34:27 -0700 (PDT) Mat Martineau wrote:
>>> This series includes three initial patches that we had queued in our
>>> mptcp-net branch, but given the likely timing of net/net-next syncs this
>>> week, the need to avoid introducing branch conflicts, and another batch
>>> of net-next patches pending in the mptcp tree, the most practical route
>>> is to send everything for net-next.
>>
>> So, that's the reasoning, but I'll send v2 without the cc's.
>
> No need, I can strip when applying.
>

Thanks Jakub, appreciate this!


- Mat

