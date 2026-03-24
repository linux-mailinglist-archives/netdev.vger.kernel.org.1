Return-Path: <netdev+bounces-271139-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCtxNLK1wmlolAQAu9opvQ
	(envelope-from <netdev+bounces-271139-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:02:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB22D318945
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 46D6730489A5
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 15:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F28B35FF73;
	Tue, 24 Mar 2026 15:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="eXw+jp8P";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="eXw+jp8P"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E0929ACC6;
	Tue, 24 Mar 2026 15:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774367383; cv=none; b=ALMnWfgjcgVmAgzZeYblir+iI0D1G7a2igew2PV9tYok6BLJSjr7LZq1RHlND68FAizu7mDwhSrqnIMl0+hke8D+E6DnbykxQIfwtzjhw3AYZZkMYVmvfb2t8pPS73EG1c26wRLxHVKZ5Dlx64qZmvzU93K8Bk3yR5CMrSmRcQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774367383; c=relaxed/simple;
	bh=JXPhSN25PkvSyYgqUfWTv4KsCeLH7f+Wz4ZSNFpRWIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kwIqLb27AbOhcS7esQmJdLaRanlhYSAt14sVDA5AHd4utRyuEqMsFEs0K4qnYmkVVmIIK6lkLiihv45EvZFkY4epAWhziPzahmurtrN+meoIccsqLxTItQScAxOczNHMNfphuAeBKl3rANe8SoanNXfrZY6ulaUQRLEjvAfa+8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=eXw+jp8P; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=eXw+jp8P; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1774367373;
	bh=JXPhSN25PkvSyYgqUfWTv4KsCeLH7f+Wz4ZSNFpRWIY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eXw+jp8P0GWbOiyk8wiuhOvl99Cw7IATLJHoYqZBeXA68/OW9syhxzugUF0oGMwm7
	 LIKUExhUoCMN96AP+aiTGio8hG5oDzDl4eHLk6hL37SWQjtRLsNnx1zszjYTuMHUkM
	 u7+lfnPuGJIAQJwlNhWQj2TWn4oEtde4EEm/lAiXCaLSqX8ySILzEG6v4AVJCNOw4t
	 4YwjzJRe2bFg/GfirwXKpC0plN74miN4n8Nhd+7gH0HHs/zBVmVeQv6RiignUqWOJH
	 kZNJxbwT/l1ZO5EEU5djZSy4ACgiVdD9yLCaPyh+dmXCSs27+Chcjht/oiFwyzMD8G
	 t+7HZz/Xa425A==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id E3E7440065; Tue, 24 Mar 2026 15:49:33 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1774367373;
	bh=JXPhSN25PkvSyYgqUfWTv4KsCeLH7f+Wz4ZSNFpRWIY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eXw+jp8P0GWbOiyk8wiuhOvl99Cw7IATLJHoYqZBeXA68/OW9syhxzugUF0oGMwm7
	 LIKUExhUoCMN96AP+aiTGio8hG5oDzDl4eHLk6hL37SWQjtRLsNnx1zszjYTuMHUkM
	 u7+lfnPuGJIAQJwlNhWQj2TWn4oEtde4EEm/lAiXCaLSqX8ySILzEG6v4AVJCNOw4t
	 4YwjzJRe2bFg/GfirwXKpC0plN74miN4n8Nhd+7gH0HHs/zBVmVeQv6RiignUqWOJH
	 kZNJxbwT/l1ZO5EEU5djZSy4ACgiVdD9yLCaPyh+dmXCSs27+Chcjht/oiFwyzMD8G
	 t+7HZz/Xa425A==
Received: from [IPV6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb] (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 001823FFF2;
	Tue, 24 Mar 2026 15:49:32 +0000 (UTC)
Message-ID: <3e0b86c2-0120-4c09-9c18-f5f53576070d@birger-koblitz.de>
Date: Tue, 24 Mar 2026 16:49:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,v3,1/2] r8152: Add support for 5Gbit Link Speeds and
 EEE
To: Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, kuba@kernel.org
References: <20260320-rtl8157_next-v3-1-1aefeca7fda7@birger-koblitz.de>
 <20260324105523.385444-1-pabeni@redhat.com>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <20260324105523.385444-1-pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	TAGGED_FROM(0.00)[bounces-271139-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lkml.org:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,birger-koblitz.de:dkim,birger-koblitz.de:mid]
X-Rspamd-Queue-Id: AB22D318945
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Paolo,

thanks for reviewing the patch.
On 24/03/2026 11:55 am, Paolo Abeni wrote:
> 
> The new NWAY_5000M_FULL falls through to 'default: break;', which means
> ups_flags_speed() is never called. This results in incorrect UPS flags
> (speed bits = 0) being written to the USB_UPS_FLAGS hardware register via
> ocp_write_dword().
> 
> When the device enters UPS power saving mode at 5000M link speed, will the
> hardware receive correct speed information?
> 
> The follow-up commit defca1127dd51 ('r8152: Add support for the RTL8157
> hardware') enables support_5000full for RTL_VER_16 but also does not add a
> NWAY_5000M_FULL case to r8156_ups_flags().
> 

The exact same point was raised before:
https://lkml.org/lkml/2026/3/19/1765
it was answered by me here: https://lkml.org/lkml/2026/3/20/242 and
the answer was accepted here: https://lkml.org/lkml/2026/3/20/464

B.


