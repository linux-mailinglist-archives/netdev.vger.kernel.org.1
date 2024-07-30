Return-Path: <netdev+bounces-114139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF169412AA
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 14:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B95EA282886
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 12:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3F619E80F;
	Tue, 30 Jul 2024 12:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJV9MaMq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F08A18E77B;
	Tue, 30 Jul 2024 12:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722344224; cv=none; b=VFDDGKAZxXJCNlOF5BiUgCt5A9CD/Oe++/EbuFYWYM2ZRYwcAiUve6N6d8ABH3xlgyoVMRPr3w9yKu8SiqxFDhNv42ibD2Au3vJnmUeDJ9DPbTB2X1bPh0aspJwTFEZBOWjkXA1hjs85ge1qwWNhvx+5Z/3gEroe/8JNxIkkwJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722344224; c=relaxed/simple;
	bh=yNbXPKYUBGftoQwti/EJPPttDBGzoHi6qNUXdagY44E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBt3ftiwi9OaAvgez4cw+1HSRJ5c880I6w19NEfSeIxmOG8S+9dD9aZck9A50AZ3FqM0zD7nddl513Q7GhHI3XxCMEE67PlSXYVgPuia93Qg9zrmNB4dAhJBW0WhtWMlC9eyFkeVwAzE1nJ4Gz92bEJ0qZFucQxL0monaovywPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJV9MaMq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828B0C32782;
	Tue, 30 Jul 2024 12:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722344224;
	bh=yNbXPKYUBGftoQwti/EJPPttDBGzoHi6qNUXdagY44E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NJV9MaMq6BbxrNG3PmPm4QS7WLvZZgdXHcrU+GCDdNDqfcmE0Scf0E75o5sRWh4KT
	 DFfq0e0O8QiQyGG3rSfCae67X+3Eh6a+CB1tdiTgBoSxn2IHJycLRKaj82fLEYVWeh
	 yOpv2lcCcsnsud6YNJJtFrcVbL1bH7Uf7c00e+Fy+Lc2+DfROkDqAXY7Xo/cTgJQ7M
	 rFfmkmHxhQJ137SAO9r05iyz5Rzi9IXXwEAjwD6qvwegfHZrydYZb+E3QdFbT+oQ1P
	 O2nq7DWMilcbmdxPKWsC1L/Ig8JvcU8y1LxAoeZ9WrVaypVmT0j8vbfgrTFVnB0kcC
	 UKAadxJl1cp8Q==
Date: Tue, 30 Jul 2024 13:57:00 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	kuba@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: Add skbuff.h to MAINTAINERS
Message-ID: <20240730125700.GB1781874@kernel.org>
References: <20240729141259.2868150-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729141259.2868150-1-leitao@debian.org>

On Mon, Jul 29, 2024 at 07:12:58AM -0700, Breno Leitao wrote:
> The network maintainers need to be copied if the skbuff.h is touched.
> 
> This also helps git-send-email to figure out the proper maintainers when
> touching the file.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

I might have chosen the NETWORKING [GENERAL] rather than the
NETWORKING DRIVERS section. But in any case I agree skbuff.h
should be added to Maintainers.

Reviewed-by: Simon Horman <horms@kernel.org>

