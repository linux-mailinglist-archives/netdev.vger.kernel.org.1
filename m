Return-Path: <netdev+bounces-52374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4CD7FE839
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 05:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFB2328210B
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 04:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F9815AED;
	Thu, 30 Nov 2023 04:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Unz71rzF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDAC11C9B
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 04:19:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16753C433C7;
	Thu, 30 Nov 2023 04:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701317946;
	bh=ARuCMltqyLMBCdLO7ikDyl7oNnOclmkSM+af3JjWnos=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Unz71rzFmr/PSnlzUtB2vGgOXzD+F8oX+Ks7YLJ6GHEaDUBHjF+VVTih6/c0fWKvi
	 vS89iPQAlQWXLh1dbIRB8XP+//Fn+l4pQCX9Xc4t/cXU7fGcpqNavz8Th0SMuqyDN+
	 AOrATferedjz+2EweGcRw7GYHglI/CozicP21MuHIfQU6kC9eq7LrEKkplnFL36ja9
	 Y10LK5uOeeKsVLRBiL91Q4ryelBKRwMZEgKFWVUO8cSRSIXunYSXp3/oV+HHpNbuZb
	 rac7JaQEIKFLJIADp+G05in0zoqCjgXcmdVUoNVp1QGvzXl27tAkBQMpaCTH0ubk2P
	 r0qq0kD6Sl14A==
Date: Wed, 29 Nov 2023 20:19:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
 <kuni1840@gmail.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v3 net-next 0/8] tcp: Clean up and refactor
 cookie_v[46]_check().
Message-ID: <20231129201905.1959478b@kernel.org>
In-Reply-To: <20231130003349.60533-1-kuniyu@amazon.com>
References: <20231129022924.96156-1-kuniyu@amazon.com>
	<20231130003349.60533-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Nov 2023 16:33:49 -0800 Kuniyuki Iwashima wrote:
> I just realised that Reviewed-by tag for patch 2 of v2 series contained
> a wrong email address, and I happend to copy-and-paste it for patch 1-7...
> 
> > Reviewed-by: Eric Dumazet <edumazert@google.com>  
> https://lore.kernel.org/netdev/CANn89iLy5cuVU6Pbb4hU7otefEn1ufRswJUo5JZ-LC8aGVUCSg@mail.gmail.com/
> 
> Sorry for bothering, but it would be appreciated if it's fixed while
> merging.

Fixed, thanks for catching!

