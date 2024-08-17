Return-Path: <netdev+bounces-119400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B71955755
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 13:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22E2F1C21049
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 11:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2CC14658B;
	Sat, 17 Aug 2024 11:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CiObqzl7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FD513E028;
	Sat, 17 Aug 2024 11:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723892635; cv=none; b=bCdMyZvmLe/mUW4IWDf98Kp38f1/jBFydemIWLTUJXZDyOjcuBrj17FZGA4LwVtyQtHLpWd43sMXUDV2UTegd7EyjjbSgu8iWPIfK2If1M72clxeX673sCTIkO8qPKeAWa+c93GDshS+Tfe5C5hUcfWaz0Le5tJ/TQbjt4rw0RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723892635; c=relaxed/simple;
	bh=RoaSjKEOsvea1pe1iFn+9Kas7KqCEP9UbbyoSQ5rNWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/LvF0o+5KlW83ZFaAr83cVb9WSDaHdPk2dD8LN5bwKLnzJHP/Kzu/wnS5yN5apOwMZE1aZo1DlGteSkuH4CP9GK0nRVMKHaUkt3u9HwqnkZS9n0UDTwuNWsfn0MADiiAK5Rhq+5Pmb6tkeScJp0Q/uLiE4Gra3SlZJmljFn0Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CiObqzl7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D54EC116B1;
	Sat, 17 Aug 2024 11:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723892634;
	bh=RoaSjKEOsvea1pe1iFn+9Kas7KqCEP9UbbyoSQ5rNWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CiObqzl7qaJtMfwSxGDA/0YCxjqOcVxAKzfPx/gUCnXD2Fcnh1Dv/HgjIueqIDbvu
	 bUfKHbtGuvvghvAAmaEV5dEBKFniHkC0mmFAK1GsAAYwGwjOgyc+/Xr6sCkOFViN17
	 95CyGi6uL9I+HqsCe8szC9qtt+3FdE9f+pH8tDTg=
Date: Sat, 17 Aug 2024 13:03:51 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rodolfo Zitellini <rwz@xhero.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Jiri Slaby <jirislaby@kernel.org>,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, Doug Brown <doug@schmorgal.com>
Subject: Re: [PATCH net-next 1/2] tty: Add N_TASHTALK line discipline for
 TashTalk Localtalk serial driver
Message-ID: <2024081717-mating-uncle-6e4c@gregkh>
References: <20240817093258.9220-1-rwz@xhero.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817093258.9220-1-rwz@xhero.org>

On Sat, Aug 17, 2024 at 11:32:58AM +0200, Rodolfo Zitellini wrote:
> This is the patch for the line discipline

Please look at the kernel documentation for best how to write changelog
texts.  This needs a bit of work.

thanks,

greg k-h

