Return-Path: <netdev+bounces-230222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C07BE56F3
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 22:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24EE454619B
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 20:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BA42E229E;
	Thu, 16 Oct 2025 20:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SwtH2XYz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4371A2DE1E6
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 20:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760647558; cv=none; b=TZKrUaaMUxTdd+yWxNWamcJau3sXvMacWgk+9LrS8F3Hq4Mvl9Qha8dGRUR9efOEBrAOqHehiYpTRX9BOY9lTOKUKhXwbSYxfw74YX14z2/oh36dZM11UplCEYpBniYUvINjKXN70fnjE/5p0KaQ1j5ReEYpZWxwOyFWQTC7PBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760647558; c=relaxed/simple;
	bh=ZieYExJ/Oj8QxmXz8/4mIiRF7Gv5EAYzRAE0qNr7sJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8qeLJAbIuprV70fXWcmrapjFCg7imqTMp1nC745N+auUmlIEKoPF0r2CoDNounp6B+Loy7oIia+RdtWpXuuMIU8hRDgBtQFdqaw0piF4MFptJV1ZwcZ+zQr8dRVWq38XsYvJuYLrnusPE4yOQLnfFlsu8P1A1sj9qw4akUN21I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SwtH2XYz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=LkfuaH31ia/KSOz4kEtnYol5VLG46wUi+LyNJD2+4Qk=; b=Sw
	tH2XYzAQ9gE5NRIxdn1S2YVPs1Tg6nzs0LLvRQiK6QWOUcoF6sQPwdQV0prpHy+Myw5YkQEAff9u1
	ACYgdZziIe/XOPwbJFq7JdTIypJqnMjmcagLCNdorJFXJHjrpfTGcWFSRjwCc5OMhBoAatH2IBfoL
	g1f+DeFi7QRgKJE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v9UrC-00BCnt-29; Thu, 16 Oct 2025 22:45:54 +0200
Date: Thu, 16 Oct 2025 22:45:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: Netdev <netdev@vger.kernel.org>
Subject: Re: Build commit for Patchwork?
Message-ID: <36bdcfd5-3388-4a6e-80fc-f05bfe0d6a03@lunn.ch>
References: <CAGXJAmwrPr46Ju-ZiLa7prnNFAcGr7Hu-vpk1B6-Q9Ks8fu8wQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXJAmwrPr46Ju-ZiLa7prnNFAcGr7Hu-vpk1B6-Q9Ks8fu8wQ@mail.gmail.com>

On Thu, Oct 16, 2025 at 09:07:09AM -0700, John Ousterhout wrote:
> Is there a way to tell which commit Patchwork uses for its builds?
> 
> Patchwork builds are generating this error:
> 
> ‘struct flowi_common’ has no member named ‘flowic_tos’; did you mean
> ‘flowic_oif’?

commit 1bec9d0c0046fe4e2bfb6a1c5aadcb5d56cdb0fb
Author: Guillaume Nault <gnault@redhat.com>
Date:   Mon Aug 25 15:37:43 2025 +0200

    ipv4: Convert ->flowi4_tos to dscp_t.

diff --git a/include/net/flow.h b/include/net/flow.h
index a1839c278d87..ae9481c40063 100644
--- a/include/net/flow.h
+++ b/include/net/flow.h
@@ -12,6 +12,7 @@
 #include <linux/atomic.h>
 #include <linux/container_of.h>
 #include <linux/uidgid.h>
+#include <net/inet_dscp.h>
 
 struct flow_keys;
 
@@ -32,7 +33,7 @@ struct flowi_common {
        int     flowic_iif;
        int     flowic_l3mdev;
        __u32   flowic_mark;
-       __u8    flowic_tos;
+       dscp_t  flowic_dscp;
        __u8    flowic_scope;
        __u8    flowic_proto;
        __u8    flowic_flags;

Andrew

