Return-Path: <netdev+bounces-225748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F27B97F00
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 02:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 647F83BE7DA
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 00:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F37CA6F;
	Wed, 24 Sep 2025 00:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b="NdWVh3G1"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-g3-154.zohomail360.com (sender4-g3-154.zohomail360.com [136.143.188.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06AF4A35
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 00:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758674751; cv=pass; b=Dx+pBkN2rKReWDH4FXeoIb7cthYaMiQ9jsmqQ7Dv+dKVZRaGCsejr/GyWDnLeATrrK3SkfoaE71ld5wBqQ6E32ZYaQs9U2VMuafsWS2/8iSB1xO6YfRenNmXfGvis45h3v1XYAL83woTd5IacxYmam7OcwusKA+H+tivQQ/qXi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758674751; c=relaxed/simple;
	bh=oi4R8c4MgwjwK+TTcFQxOesTdzAxcogkHs5IOioNJbM=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=V2AJDDf0ylzOKP6mvmUSFSwLEexhARQvM/iki/f2VS4M16kNtl/VBl6Ssx3g2h0TvRN6Btdp9mJRvtP5afK3V5Y5p14YBWzRqy9smbIg4RP4K1WQ+GuW81IHlOGZwdAZTaAXivkctiirQUSy3Bb3eGo9tpiTRcSyRSksDy/P5wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx; dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b=NdWVh3G1; arc=pass smtp.client-ip=136.143.188.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx
ARC-Seal: i=1; a=rsa-sha256; t=1758674747; cv=none; 
	d=us.zohomail360.com; s=zohoarc; 
	b=e49lySlb9t7fjWi9tNku7JjkxXy07i/7wd50p/RW+tPQ0o68m4I3RICc+wN5YC9O8QIft6oVKcVyDWW3KSaz3z5c/qp7PjibQaOEfA38Hlk2jZvKgYX+5POy7IssSBNsZaVKR1i2Eh5snVL+ped3PHs4NsRUBxbbjqwPtG762gM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=us.zohomail360.com; s=zohoarc; 
	t=1758674747; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Reply-To:Reply-To:Subject:Subject:To:To:Message-Id:Cc; 
	bh=oi4R8c4MgwjwK+TTcFQxOesTdzAxcogkHs5IOioNJbM=; 
	b=Zf1g4YSsH95AM+v+2qzHyZDntCN60JQLu7XfXqgsioZwG26erTkKX72r7lRglVNk3sDweDJhZC6CSsceA4nvw94z+oYQWilp+eJkIBHL/dlr2jd6NzdlcTklw3cf6LEGdt9f759jmD8D7IOHVVWK+QKsvTMZJUQhjej9sSFb9Gc=
ARC-Authentication-Results: i=1; mx.us.zohomail360.com;
	dkim=pass  header.i=maguitec.com.mx;
	spf=pass  smtp.mailfrom=investorrelations+1589c140-98d9-11f0-8217-5254007ea3ec_vt1@bounce-zem.maguitec.com.mx;
	dmarc=pass header.from=<investorrelations@maguitec.com.mx>
Received: by mx.zohomail.com with SMTPS id 175867185957018.91936189267051;
	Tue, 23 Sep 2025 16:57:39 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; b=NdWVh3G1Xyv1ajd2jwWbUz4aU5m0bQcHK7UyH+eXKTUCInWQfr3mSU4pbW/6IjpE6WmbUj2v2cxpCXSnc02gqPmGXJlcH8yHzsNQaKgIVnF7a3BuxWjBj4Z+n2fMF1BKCIME1O8cwcl8geWkQeF2E+SwEk65EmXvM0sYvpq/sT0=; c=relaxed/relaxed; s=15205840; d=maguitec.com.mx; v=1; bh=oi4R8c4MgwjwK+TTcFQxOesTdzAxcogkHs5IOioNJbM=; h=date:from:reply-to:to:message-id:subject:mime-version:content-type:content-transfer-encoding:date:from:reply-to:to:message-id:subject;
Date: Tue, 23 Sep 2025 16:57:39 -0700 (PDT)
From: Al Sayyid Sultan <investorrelations@maguitec.com.mx>
Reply-To: investorrelations@alhaitham-investment.ae
To: netdev@vger.kernel.org
Message-ID: <2d6f.1aedd99b146bc1ac.m1.1589c140-98d9-11f0-8217-5254007ea3ec.1997902eb54@bounce-zem.maguitec.com.mx>
Subject: Thematic Funds Letter Of Intent
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
content-transfer-encoding-Orig: quoted-printable
content-type-Orig: text/plain;\r\n\tcharset="utf-8"
Original-Envelope-Id: 2d6f.1aedd99b146bc1ac.m1.1589c140-98d9-11f0-8217-5254007ea3ec.1997902eb54
X-JID: 2d6f.1aedd99b146bc1ac.s1.1589c140-98d9-11f0-8217-5254007ea3ec.1997902eb54
TM-MAIL-JID: 2d6f.1aedd99b146bc1ac.m1.1589c140-98d9-11f0-8217-5254007ea3ec.1997902eb54
X-App-Message-ID: 2d6f.1aedd99b146bc1ac.m1.1589c140-98d9-11f0-8217-5254007ea3ec.1997902eb54
X-Report-Abuse: <abuse+2d6f.1aedd99b146bc1ac.m1.1589c140-98d9-11f0-8217-5254007ea3ec.1997902eb54@zeptomail.com>
X-ZohoMailClient: External

To: netdev@vger.kernel.org
Date: 24-09-2025
Thematic Funds Letter Of Intent

It's a pleasure to connect with you

Having been referred to your investment by my team, we would be=20
honored to review your available investment projects for onward=20
referral to my principal investors who can allocate capital for=20
the financing of it.

kindly advise at your convenience

Best Regards,

Respectfully,
Al Sayyid Sultan Yarub Al Busaidi
Director

