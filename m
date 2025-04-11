Return-Path: <netdev+bounces-181669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50234A860C7
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 16:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AA634A81E9
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 14:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373631F099A;
	Fri, 11 Apr 2025 14:37:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vuizook.err.no (vuizook.err.no [178.255.151.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1004027450
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 14:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.255.151.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744382252; cv=none; b=t7s8bEncm3xRewBQnfexpN29TgvAIl6oSK3Tq3ransOhd4BSCMv71AqYscooiBcSY93IkCCUDf343uifr4awzRNMZQAjfYpMYHu2DOPoxJHpz9Thzgg1vPi7UrUJ0Ts+Z0hgFtVg3oSZ+eNUo5O3UgvPu3QVliVnnMWASdW1qOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744382252; c=relaxed/simple;
	bh=kANKDkRH8Ld7qfR36oZEthE/EaflR+xeNMOx1e/3CC8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GqPQuUcdrf7RX5dr7IlLuIaDvKUvzQESWC1yEhEc+/RA9k2nEQ3EJoLK4NgLkcD4kiGq9TkJgzbvQXpOgwPBm3uDMHt+sBi+6kSj5oQDdS+6BZXNrrTsX2IbMjKPCtXOUY2Ab4rzqFbzoAxdS6eIWSa//CF2STsqCAuNLZDIboc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hungry.com; spf=none smtp.mailfrom=hungry.com; arc=none smtp.client-ip=178.255.151.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hungry.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hungry.com
Received: from [2a02:fe1:180:7c00:3cca:aff:fe28:58e0] (helo=hjemme.reinholdtsen.name)
	by vuizook.err.no with smtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <pere@hungry.com>)
	id 1u3F2p-00C7Iy-1Z;
	Fri, 11 Apr 2025 14:07:52 +0000
Received: (nullmailer pid 1173647 invoked by uid 10001);
	Fri, 11 Apr 2025 14:07:42 -0000
From: Petter Reinholdtsen <pere@hungry.com>
To: AsciiWolf <mail@asciiwolf.com>, Michal Kubecek <mkubecek@suse.cz>
Cc: netdev@vger.kernel.org, Robert Scheck <fedora@robert-scheck.de>
Subject: Re: ethtool: Incorrect component type in AppStream metainfo causes
 issues and possible breakages
In-Reply-To: <CAB-mu-QjxGvBHGzaVmwBpq-0UXALzdSpzcvVQPvyXjFAnxZkqA@mail.gmail.com>
References: <p3e5khlw5gcofvjnx7whj7y64bwmjy2t7ogu3xnbhlzw7scbl4@3rceiook7pwu>
 <CAB-mu-QjxGvBHGzaVmwBpq-0UXALzdSpzcvVQPvyXjFAnxZkqA@mail.gmail.com>
Date: Fri, 11 Apr 2025 16:07:41 +0200
Message-ID: <sa6semeokpe.fsf@hjemme.reinholdtsen.name>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

[AsciiWolf]
> Sure,
>
> I will take a look at this later today.

This is my cut-n-paste error.  The reporter is absolutely correct that
the component type should not be desktop as there is no .destop file
associated with the package.

The quick and actually working fix is to replace '<component
type="desktop">' with '<component>'.  A more correct entry would be to
use '<component type="console-application">', but at least on Debian
these two are equivalent.

I am terribly sorry for not noticing when I sent the original patch.

-- 
Happy hacking
Petter Reinholdtsen

