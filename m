Return-Path: <netdev+bounces-38041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 275F57B8B4E
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 20:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 380E6B20813
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 18:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9112200B9;
	Wed,  4 Oct 2023 18:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzZFwcE3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD211D6A9
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 18:52:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A96C433C8;
	Wed,  4 Oct 2023 18:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696445542;
	bh=x4Pg5cXI3dCKI7KGq5PPllrfX7jO8ITvdEruIzR40UA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VzZFwcE3SXKBH55CeuvlpjLwmP1bWb8ikJ6s5jkw+LmkcV4L2zIXuppz7Hi1cLLyq
	 KU4Im2Mx7mNHkm/LayF9xGz4oJpj/S+GfE8WjCE/ganc8cg8GrDvcKlKoh/csUH4B1
	 qlL6g1N1r+ga0JBsk45D8vz4M5qJHxWKKh7qPXOkNlGs58KRHNOGTfP49X9pYhTQwk
	 lb5sCiJIrlXGvB6CEryfmPXMZZX5IT6ttRQJSFZuBM2jYiQ+ge6y3gbFhJbHbIZj0t
	 om9F8loyB34QmwIp+oWS70Q9SIHwbMLv/M2VRRFgHbHLsGsoTsRv1vSS6NJO0kalfs
	 J6er07+2ZqL1A==
Date: Wed, 4 Oct 2023 11:52:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-spdx@vger.kernel.org, Prarit Bhargava <prarit@redhat.com>, Christoph
 Hellwig <hch@infradead.org>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 jschlst@samba.org, Doug Brown <doug@schmorgal.com>, Arnd Bergmann
 <arnd@arndb.de>
Subject: Re: [PATCH] net: appletalk: remove cops support
Message-ID: <20231004115220.5c3776eb@kernel.org>
In-Reply-To: <20230927090029.44704-2-gregkh@linuxfoundation.org>
References: <20230927090029.44704-2-gregkh@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Sep 2023 11:00:30 +0200 Greg Kroah-Hartman wrote:
> The COPS Appletalk support is very old, never said to actually work
> properly, and the firmware code for the devices are under a very suspect
> license.  Remove it all to clear up the license issue, if it is still
> needed and actually used by anyone, we can add it back later once the
> license is cleared up.

Nice, Doug and Arnd also mentioned this in the past so let me add
them to the CC as I apply this...

