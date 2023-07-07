Return-Path: <netdev+bounces-16155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E170574B964
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 00:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 909262816E2
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 22:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D7B17AD2;
	Fri,  7 Jul 2023 22:12:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4782617ACA
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 22:12:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85FC6C433C8;
	Fri,  7 Jul 2023 22:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688767927;
	bh=3GVQ87GFe/N128MNUePXr84Z9uHM4Shi5hKdcsz++pk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UCsdXbwFZFiiJemnLWCQWnzrj2oZ3dKL/+o7acuwgqUaBAyKgov0z53Ajpfg1yYvw
	 62GtDgzdZwQfVJbN1vQkblhb1t3WJcLicm1xUtgwab6zJlV8EAodg0FLIA13tFHzhZ
	 sR5pjSjo+5gdgzrJOa+D1rOqt7PRhjn/tbIgYqROLl8lazsX6Vewi4a0ACenVtd+1h
	 few1IE8yrG9wAepF6R0qdlG+C9/7B51P5v3eKX/WQyR7VD+r2lQ/0rzedIdymWzMNn
	 FhXhYR9RpYck/Vr+tKjYTiz2HIDTRsxZnPVlqM/fMhHh1304cbzmBqld+L8yqKMrP+
	 vmlHyal6159IA==
Date: Fri, 7 Jul 2023 15:12:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Forbes <jforbes@fedoraproject.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jacob Keller
 <jacob.e.keller@intel.com>, Andrew Lunn <andrew@lunn.ch>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jmforbes@linuxtx.org
Subject: Re: [PATCH] Move rmnet out of NET_VENDOR_QUALCOMM dependency
Message-ID: <20230707151206.137d3a94@kernel.org>
In-Reply-To: <CAFbkSA0wW-tQ_b_GF3z2JqtO4hc0c+1gcbcyTcgjYbQBsEYLyA@mail.gmail.com>
References: <20230706145154.2517870-1-jforbes@fedoraproject.org>
	<20230706084433.5fa44d4c@kernel.org>
	<CAFbkSA0wW-tQ_b_GF3z2JqtO4hc0c+1gcbcyTcgjYbQBsEYLyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Jul 2023 11:50:16 -0500 Justin Forbes wrote:
> > On Thu,  6 Jul 2023 09:51:52 -0500 Justin M. Forbes wrote:  
> > > The rmnet driver is useful for chipsets that are not hidden behind
> > > NET_VENDOR_QUALCOMM.  Move sourcing the rmnet Kconfig outside of the if
> > > NET_VENDOR_QUALCOMM as there is no dependency here.
> > >
> > > Signed-off-by: Justin M. Forbes <jforbes@fedoraproject.org>  
> >
> > Examples of the chipsets you're talking about would be great to have in
> > the commit message.  
> 
> The user in the Fedora bug was using mhi_net with qmi_wwan.

Hm, if anything mhi_net should not be sitting directly in drivers/net/

I don't think this is a change in the right direction, just enable
VENDOR_QUALCOMM? Or am I missing something?

