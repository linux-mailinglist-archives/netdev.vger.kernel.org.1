Return-Path: <netdev+bounces-256100-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HxPNnhqgWnHGAMAu9opvQ
	(envelope-from <netdev+bounces-256100-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 04:24:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E66D418A
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 04:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2CB8F3016251
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 03:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A78B125D0;
	Tue,  3 Feb 2026 03:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="f+FIEuV6"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09904A02;
	Tue,  3 Feb 2026 03:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770088600; cv=pass; b=kyV2dIOIwGKtNq+Ff2uTkR/9QM33NBpLAQKEXjQHEG9ge288y141R4fb1yt8eLW+dcpRtXgHrugwVlxdjVCKvKpRwxSgzGIBxhla9Z8vw1XvTMZ8ONZ8ZkoyRNUMiCz9FvJfCJwWDAHAjvDemJhZYdlXftRjmrpL4yptpIM2DCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770088600; c=relaxed/simple;
	bh=5DA/7q872cDuWWwNfH//W/HGa/yB+iGjMAlNdfl7RgY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=XKIXpphmE+J2jVZO2AiZepjY7ZxdDp9jkK1JEBN9uSOhhGLXhxD29Q33IvWM2XJ54avzbk5oeiPqW9v9qDuFwPq6SlAp2aN6XL4lI1RBeAVyZtnLV6+FY1KNSG9voVYhag1UUh8sVSl7jMU8cGhv5DzIsaywzPQvnwOwvhqMKvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=f+FIEuV6; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1770088550; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HwSnGrPoGxqoxPSTGQfuiEZa4xmoimt+7uGimmczz6nmBoFpz42299cEmXa1BC5P3CB89GG1LKGKxlQjmRfqoleH0gtWTUXq8/Oh2iunJgMGgQSJP6SGX9/GsWMXzTKr9YjTujnW8MUkPABHVD8wTqcHrIh4ZT1MULoM5/YwH6g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770088550; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=X8+GuxP4m2ZUTrtpMv2HBNnZidrxrNTCjaDLyXoNVgY=; 
	b=kq6VgdOsLV5h5rjpYN+AFPSBU5Rnyhojjs1J5gZhfzTnHlYLNih59zzcTNqPlWGwcrsVIj4QxseDaeHGa/CAG7Hlozdz8ZWd+ITEu31IDnRAV6RYUxxZVPR0dbXgGneiO9xNns7Vp9KcbJEMEbNpCVXlRtr4FZ946LLIJLtT6Xw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770088550;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=X8+GuxP4m2ZUTrtpMv2HBNnZidrxrNTCjaDLyXoNVgY=;
	b=f+FIEuV6ihjMGPgEuVMPTaE7aE7lg1wcWB7ZqLGRzC8Pp7E0S0oZFWNRxoUgH0Of
	HR7PODCoxIYjNee9vwEuh//Wws1lV7a9Am0zsNj6RsP+DCquLWs+kH47XadJx+fiUgy
	gEPiBw5iP3hb/83FPpsUmHme55WfW1nsdQsxDM4s=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1770088549169349.2799433103546; Mon, 2 Feb 2026 19:15:49 -0800 (PST)
Date: Tue, 03 Feb 2026 11:15:49 +0800
From: Li Chen <me@linux.beauty>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: "Jonathan Corbet" <corbet@lwn.net>,
	"Pasha Tatashin" <pasha.tatashin@soleen.com>,
	"Mike Rapoport" <rppt@kernel.org>,
	"Pratyush Yadav" <pratyush@kernel.org>,
	"Eric Dumazet" <edumazet@google.com>,
	"Neal Cardwell" <ncardwell@google.com>,
	"Kuniyuki Iwashima" <kuniyu@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	"David Ahern" <dsahern@kernel.org>,
	"Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	"Borislav Petkov" <bp@alien8.de>,
	"Randy Dunlap" <rdunlap@infradead.org>,
	"Pawan Gupta" <pawan.kumar.gupta@linux.intel.com>,
	"Petr Mladek" <pmladek@suse.com>,
	"Feng Tang" <feng.tang@linux.alibaba.com>,
	"Kees Cook" <kees@kernel.org>, "Li RongQing" <lirongqing@baidu.com>,
	"Arnd Bergmann" <arnd@arndb.de>,
	"Askar Safin" <safinaskar@gmail.com>,
	"Frank van der Linden" <fvdl@google.com>,
	"linux-doc" <linux-doc@vger.kernel.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"netdev" <netdev@vger.kernel.org>
Message-ID: <19c217fcb23.839ade332430911.7160767633796349662@linux.beauty>
In-Reply-To: <20260202165320.7ddb25f8@kernel.org>
References: <20260130145122.368748-1-me@linux.beauty>
	<20260130145122.368748-4-me@linux.beauty>
	<20260130170533.257db5fb@kernel.org>
	<19c16df6e07.5d6555571430461.7492468111934043630@linux.beauty> <20260202165320.7ddb25f8@kernel.org>
Subject: Re: [PATCH v1 3/3] liveupdate: suppress TCP RST during post-kexec
 restore window
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [7.35 / 15.00];
	URIBL_BLACK(7.50)[linux.beauty:mid,linux.beauty:dkim];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	R_DKIM_ALLOW(0.00)[linux.beauty:s=zmail];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,body];
	TAGGED_FROM(0.00)[bounces-256100-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[linux.beauty];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lwn.net,soleen.com,kernel.org,google.com,davemloft.net,redhat.com,linux-foundation.org,alien8.de,infradead.org,linux.intel.com,suse.com,linux.alibaba.com,baidu.com,arndb.de,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[linux.beauty:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@linux.beauty,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.753];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.beauty:mid,linux.beauty:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 52E66D418A
X-Rspamd-Action: add header
X-Spam: Yes

Hi Jakub,

 ---- On Tue, 03 Feb 2026 08:53:20 +0800  Jakub Kicinski <kuba@kernel.org> =
wrote ---=20
 > On Sun, 01 Feb 2026 09:44:27 +0800 Li Chen wrote:
 > >  > On Fri, 30 Jan 2026 22:51:19 +0800 Li Chen wrote: =20
 > >  > > During a kexec-based live update, userspace may restore establish=
ed TCP
 > >  > > connections after the new kernel has booted (e.g. via CRIU). Any =
packet
 > >  > > arriving for a not-yet-restored socket will hit the no-socket pat=
h and
 > >  > > trigger a TCP RST, causing the peer to immediately drop the conne=
ction. =20
 > >  >=20
 > >  > Can you not add a filter to simply drop those packets until workloa=
d is
 > >  > running again? It'd actually be less racy than this hac^w patch ...
 > >  >  =20
 > >=20
 > > Thanks for the suggestion.
 > >=20
 > > When you say "add a filter", do you mean installing a temporary drop r=
ule
 > > (nftables/iptables/tc) in the network domain which does not get reboot=
ed by
 > > kexec (e.g. LB/ToR/host firewall), so packets never reach the new kern=
el
 > > until the workload is restored and ready?
 > >=20
 > > If you meant a filter inside the kexec'ed kernel, I'm worried it won't=
 cover
 > > the critical window: kexec resets the ruleset, so we'd have to install=
 the
 > > drop rule extremely early (initramfs) before any packets hit the no-so=
cket
 > > path, which still seems inherently racy.
 >=20
 > I'm not sure what your flow is exactly, but I assume you drive=20
 > the workload restore from user space already?
 >=20

Yes, in our PoC setup the post-kexec restore flow is driven from initramfs =
/ early userspace.

We pass an initramfs via kexec --initrd and install a temporary iptables IN=
PUT DROP rule from a dracut pre-mount hook (keyed by a cmdline like luo_tcp=
_drop_port=3D...). In our
external-peer test this avoids the early TCP RST window; the peer just retr=
ansmits/timeouts until CRIU restore recreates the socket.

The downside is that it makes initramfs heavier (iptables userspace + requi=
red xtables extensions, and it relies on legacy iptables filter support bei=
ng available early). Not sure
this is a great general solution, but it can work when initramfs is under o=
ur control.

Regards,
Li=E2=80=8B


