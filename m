Return-Path: <netdev+bounces-275894-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPt3JEO81GlRwwcAu9opvQ
	(envelope-from <netdev+bounces-275894-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 10:11:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE5D3AB211
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 10:11:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 771AD3004CBF
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 08:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195D93A3E81;
	Tue,  7 Apr 2026 08:11:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F241B3A3E72
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 08:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775549501; cv=none; b=kOR1TWpPlZ4dZLM/j2DO3lvyN+JyYjGEelQq3cECUgsk/ml3fgQNS53m9umTVrkPFup9ZbGmdSQru/C+4i0LZVpUB3odbAAc+tbprmgLbwjXpDwdNTponzl3CjMHbK8jHwoXQcuEPcWD9cSV26eGueQoQLXjczKkiXFCdXQ9CGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775549501; c=relaxed/simple;
	bh=Mb910JIaKwZe2patqm2uCUUaQgXoq+nhCRjppMWfnRM=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=tS50EDpU16Ouph27FCvFsN4q0UXsJh2Z5MyhNbmP1PRIh7XYs+JpnfCD9ijU5vG91NrfH9lMQNNrpBNf0HjQk1hSS/icJdIV3K6WD8kz6weF8MITbf5QgO0ec/yCmY7cOZ3abJgd0p+LF/wO/asmkqkeufPaM/eLCBqQu/a5cZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas3t1775549243t653t01181
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [115.220.225.134])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 11981075419421733400
To: "'Russell King \(Oracle\)'" <linux@armlinux.org.uk>
Cc: <netdev@vger.kernel.org>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Simon Horman'" <horms@kernel.org>,
	"'Jacob Keller'" <jacob.e.keller@intel.com>,
	"'Abdun Nihaal'" <abdun.nihaal@gmail.com>,
	<stable@vger.kernel.org>,
	<netdev@vger.kernel.org>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Simon Horman'" <horms@kernel.org>,
	"'Jacob Keller'" <jacob.e.keller@intel.com>,
	"'Abdun Nihaal'" <abdun.nihaal@gmail.com>,
	<stable@vger.kernel.org>
References: <D56A7C3379B4DA62+20260331071107.5414-1-jiawenwu@trustnetic.com> <acvHIpPd8BL_wFFU@shell.armlinux.org.uk> <076401dcc17d$905c40b0$b114c210$@trustnetic.com> <acy5evlrUesbcB46@shell.armlinux.org.uk> <096d01dcc657$9ee42b00$dcac8100$@trustnetic.com> <adS0_I_2HBH-gM19@shell.armlinux.org.uk>
In-Reply-To: <adS0_I_2HBH-gM19@shell.armlinux.org.uk>
Subject: RE: [PATCH net] net: txgbe: fix RTNL assertion warning when remove module
Date: Tue, 7 Apr 2026 16:07:22 +0800
Message-ID: <096e01dcc665$90354900$b09fdb00$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQJzBzpg8BZoKCpC0lQLuqOa6+34FQF9cQKNAr0WQJ0BAb3yuQE9QT7jArzO0LK0XQmB0A==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NZpC2jeiU30MPMCVHJPMSL0FGn2NZIVERnh6aEnY7r/qVHmSQ7KVB7PY
	raniAmkon3pKNZPZFuBVLWeSRF8ELgPgl4RlWchQ6WTtVnnI6oiSzB/AnYP5YqfXWhKnXa6
	l42PVX9ZEzTElL7XQPAeyqPeVRz9IbUV+iIUQLP5ziTtpagv8pm5cKw73bA45TT9JYKmQ8T
	XjGVaacbmapP9DZUxKhwt14LfSh7PwFlTbj3T5PWGj7Iq7h1+u2inbt2da50bdyK56Ccypk
	kXlwS9N3KjI5L6p8CmeM73THc7Ee9O7iq3IDqkCJfMpoIe8JLi6ZvSJVIKb0nb9sE5CSh+I
	tFZ7py6KWBmtitNuFbSyl12QvzOIh28i8Bmt7bRZ1kpsD9thulnP0+Gp/F9KvYL0FNCHnu0
	O8TNXawVDV5SOaFFgulyo8ChZ3aUl8LDjsoj70ZkH7EpmNq+5QYXLf/YRmuVUbsTTK6rt83
	DWTYvUMVdY2LfsA0PuVUyVHC+xHH6oVIanMONDIPk7tUrfAUb8tcLZyxufHu0RQ9PBcCkOO
	hHvVZp7zK9IraXZnrEkKCgh1v+6iAm2RcOVIASP2NzMMTe8rH3+ErgDxAue2zM7KCOHrCQS
	Zro5wZ/fzzlRP8bOaF7MYKCN3OLGGkv7k/M7jbc/BT9hzRKrPTAuc6zZrl73STSCvo3Bt/0
	w4CKD+X+ScbBQJzYA4fhERLwmh7FWq63T12sNxy0/ly2vxajXiUu9h+BaRsrOfUrL0FEhQk
	Yi5BH+PZ65wJsIVVlHhgw+Tyf05pFOjQt4Rshe+02S7AGttpykwQifKFjV84b0HwZAgUeIA
	h4M3Lf9Uc9eDqqMB/MHhVjvmejxyDkdMyGj2GKDTAxQO14muuMMqV1s86SFVj2d0dzRQecQ
	myTRpSlGPbq59ku5HTAnTM8Cux++7eSFea5jRw7X+kae+aFlwYvXglaVQ/GELdCFkx+Fp7T
	zkb8o8oHFyYctWeSUrAGJnJwMntBHKCNusQ/N+0vmfQsP+UMrcGTxOtqs0LhjyyK3VY9YD4
	9mM0DP7LJpbXIO8HyVVZYnV3yowwjJjutpJKiIg0HkJDsRKBQWGAqmKz0hgdVj/wZJwNLqk
	k+Z/4kEMy4oKXH68L0IdQwerYRwZDbSSDG40NPea4UNFsy+AiQ3Nhg=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	FROM_EXCESS_BASE64(1.50)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275894-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_SPAM(0.00)[0.097];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,trustnetic.com:mid]
X-Rspamd-Queue-Id: 8EE5D3AB211
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 7, 2026 3:41 PM, Russell King (Oracle) wrote:
> On Tue, Apr 07, 2026 at 02:27:34PM +0800, Jiawen Wu wrote:
> > On Wed, Apr 1, 2026 2:22 PM, Russell King (Oracle) wrote:
> > > On Wed, Apr 01, 2026 at 10:16:34AM +0800, Jiawen Wu wrote:
> > > > On Tue, Mar 31, 2026 9:08 PM, Russell King (Oracle) wrote:
> > > > > On Tue, Mar 31, 2026 at 03:11:07PM +0800, Jiawen Wu wrote:
> > > > > > For the copper NIC with external PHY, the driver called
> > > > > > phylink_connect_phy() during probe and phylink_disconnect_phy() during
> > > > > > remove. It caused an RTNL assertion warning in phylink_disconnect_phy()
> > > > > > upon module remove.
> > > > > >
> > > > > > To fix this, move the phylink connect/disconnect PHY to ndo_open/close.
> > > > >
> > > > > Wouldn't it be simpler to just wrap the phylink_disconnect_phy() in the
> > > > > remove function with rtnl_lock()..rtnl_unlock() ?
> > > >
> > > > This is also a solution. But I think it would be nice to unify with other drivers
> > > > that call the functions in ndo_open/close.
> > >
> > > Both approaches are equally valid. Some network drivers attach the PHY
> > > at probe time (and thus can return -EPROBE_DEFER if the PHY is specified
> > > but not present). Others attach in .ndo_open which can only fail in this
> > > circumstance with no retry without userspace manually implementing that.
> > >
> > > There are other advantages and disadvantages to each approach.
> >
> > Hi,
> >
> > So is it still recommended that add rtnl_lock()...rtnl_unlock() instead of moving it?
> 
> The reaosn phylink_disconnect_phy() requires the RTNL lock is because it
> _can_ be called while the netdev is published, and the RTNL lock
> protects the networking core from the PHY being removed from the netdev,
> preventing ethtool ops into the PHY driver from running concurrently
> with the PHY's disconnection and potential later destruction.
> 
> Offering two APIs, one which requires the lock to provide that
> protection and one which doesn't would over-complicate the phylink code
> and make reviews way more difficult, as we'd now have to spot the
> wrong function being used in the wrong code path.
> 
> It's simpler for drivers that want to connect and disconnect the PHY
> at probe/remove time for them to just take the RTNL lock briefly over
> the call to phylink_disconnect_phy().
> 
> There is no "recommendation" for connecting and disconnecting the
> PHY at probe/remove time vs ndo_open/ndo_release. That's entirely up
> to the driver author. As I've already said, there are advantages and
> disadvantages of either way and that's a matter for the driver author
> to consider and select the most appropriate choice for their driver.

OK. I'll change it at v2 patch.


