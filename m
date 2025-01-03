Return-Path: <netdev+bounces-155041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE65A00C1E
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 17:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD2E53A3F5D
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 16:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFDA1FAC5E;
	Fri,  3 Jan 2025 16:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wtlreIyJ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EB71F9EA4;
	Fri,  3 Jan 2025 16:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735922213; cv=none; b=iMesgBYKVTA7RJ7XrhvxCe3MbWd8aQQjrFi71b3ka9RhOrqULZabCPpMhmodOV/YnZTvXe15T8mMYaYDcwu8ddvXodvjMo6+0BgBCdOec240jlCA4+Pigf5XDodnX2hfpFeiVsPzLgpBeL1GMhja2qRkFqezPGyDwOq8RlB32W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735922213; c=relaxed/simple;
	bh=FXOa7FZg03XO2bduiLkPgtFeSnVHz0ZSpwfN2uIfRbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7vJIafF0urZS1huoIWefnM8Vx1Ev2WjkSulEK5x8JZpkjbGDME9kPtYS2P+iZqZj81CnSJ6GArpMAXWbmK3nVDQvCr5FwZ7JJJ57PqYtFPSCC0SOmXTqoHjn3ykbfdgW9RQExPWnPhVS5VlBqTPkjMO4ocEFRUJsEKmV89YB1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wtlreIyJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Kh4cxT38Hi8RAyaK0HgpVZbIbcFEB4RE8S/6l+xHUNs=; b=wtlreIyJmVSCc650uMqzLqoDhr
	TszlHMiQNEyt1NTikAFZ7Ork0yqK+K+ghS8CL6hle+iYzHAixxlb8HG+c5EKhvSx10vaAK0N1JoYi
	d8I72NJxFqXyWI1aHH22xhZwC/TOERG0eQYlJ3AF+OMVUGcqU97hsV4xWGu+9M2L77I8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tTkfA-0015W1-Vt; Fri, 03 Jan 2025 17:36:40 +0100
Date: Fri, 3 Jan 2025 17:36:40 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Nihar Chaithanya <niharchaithanya@gmail.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	sd@queasysnail.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH] octeontx2-pf: mcs: Remove dead code and semi-colon from
 rsrc_name()
Message-ID: <5411a125-6a90-405b-9e19-378cfa823ffa@lunn.ch>
References: <20250103155824.131285-1-niharchaithanya@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103155824.131285-1-niharchaithanya@gmail.com>

On Fri, Jan 03, 2025 at 09:28:26PM +0530, Nihar Chaithanya wrote:
> The switch-block has a default branch. Thus, the return statement at the
> end of the function can never be reached.

Deja vue?

I already commented on a similar patch like this. It is not the
default: branch alone which makes the code unreachable. It is that
every case statement makes a return, not a break. This might seem
pedantic, but compiles and static analysers are pedantic, so we
software engineers also need to be pedantic.

Please update the commit message.

Please also take a read of:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

    Andrew

---
pw-bot: cr


