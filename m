Return-Path: <netdev+bounces-274111-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCQPDN4fzWnOaAYAu9opvQ
	(envelope-from <netdev+bounces-274111-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 15:38:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C3A37B5A1
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 15:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B342305B0FA
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 13:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D12742EEC7;
	Wed,  1 Apr 2026 13:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="t5e8U/1x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C4C42EED0
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 13:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775050239; cv=pass; b=fbKYhkv36hTiaYn6YcwnY4JO4PSA6g5Cw5qAnCmhROWtZmAwwJ2WeVyvHxky91kPi+aNHNdOkHGlCRKDBVHwbo6Ja9uSp3/cnSqBUwclNMtaQbgR6OxPp/s+vH6PynpSgwbla+FaTW7KkTcz923KmZdRHyZ+FmV4PQWQQnUJKfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775050239; c=relaxed/simple;
	bh=BRfaxlgXcaC4MwKGbrVI1gU9LqJpM6bbpHxRtdhQuco=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Axz50gzc2YpthM4Nx+cL0y2zL5Tpc50WnceGTnlXH4xxBJphNFLheqjO8RgF3Y+TU0cR5tPuTWY8pFz/co8GZjIPW5w7UJKz10CMxiZ0Laul+5OK51N4i6SAvh2CfHxETKloq66lWGYTQD6l71zoLFdPw/fOcIKbucve2NkQeoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=t5e8U/1x; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82cf96ca071so18542b3a.1
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 06:30:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775050237; cv=none;
        d=google.com; s=arc-20240605;
        b=Y51e9TSDFcFA7zBHU8teo/8wLBBR5Buc2/iCydFCJrOPDA2GZQ40MtCuddEn6M4/Gq
         M8s900EKVkGfT2hLbZoHK77oC+D+vjjb6OKGyWQPgh+rxE4HlX9c2InNqs3JS6ooG7xX
         Cv83YMIgd/vhJYKBD5WD/ZT+2CoMTBIXIaxr7QzscsY9Q0rf0jZvfeSkDsMDB+qcIVbM
         j+xohWASVLSjBwG5Ha0VF3I2JYwQUie11BQF2zb/+POKuT8jhEzB9rBiLRytN6jHQCBJ
         AoW5hKoc5TlAM1joTZhnI3XJUZxi6xsJ234WlU7MfoeyamUvtj+FiKOB7zJRQwzoPEEV
         Cq3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=T7NuR3Bw6Qb5rckRbbyyN8y03wjGHotEoDAqQmFwpLY=;
        fh=lBu3/v7o40Vg3xGxsLnhAVyQ6gzMitjrNM/vrosLT10=;
        b=PeKcm1V6OQp3LO/TLSio6Qzkq/jQnf9FxqXjEFTW018/tcwjfHjsHuFVYV9JNeMMQJ
         qYqld97vu+tjAvoUEIi0qk2iyfFp6b5wiCHiJwWH39w2Y5I9tNeBWgHS/2Jt3jp8/+rl
         dwCXSgxU8TDW3AwYviFLDFWjQoSthUMZOPzsBIa4pO38oOgGRGd9g3bes1MSfceBkHym
         1fVVORXHIDDs9Q6Sd7JLc1cp91tqPUpns/Lf3yhO4G3c6sTEhwuSzW+u1kAn0TZ3Wn5C
         2jjxAZcJNf2aaaZpuLm7SEATDIfeDplSCeTMU/Ghw3TOrly++M1/mEI7GhRfUJE8kfcz
         jn1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1775050237; x=1775655037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T7NuR3Bw6Qb5rckRbbyyN8y03wjGHotEoDAqQmFwpLY=;
        b=t5e8U/1xZ4c5uGBTHMld6TI1/QXjnvmHNjvQ5T+Jm2n39tqyd2cm+XRC/80ktQlpci
         rwYTXq4DFcshYjfrqCJrDMj7zKqNVcRhYEJ0ST2CEoenxEAV1nrUCTi6hfNPCGOjsBWY
         wIdGs9CmL/nTTFTkF99PGhOOiRuv4PmMOV8aZSTeI/QZNOqNQHIdJXIpJNW+uDoNpMoL
         IY8oqXyEEcjjIkvCzGTz7nRBahav/GlZI56TXRYFujav9hD9j4mSoQboUXjii6XL8kJq
         w/vVdsMnZ5whhHNYoj/VFtZkdMrewKh+LctrfAVHRW+2qX15m5iy3e7Eg1yuXFfLPl9I
         V3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775050237; x=1775655037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7NuR3Bw6Qb5rckRbbyyN8y03wjGHotEoDAqQmFwpLY=;
        b=UOd+gVzPs5HEhjVuDfq9ajs8IP5tp8vZWWFr8O+tDGwe+d+wM3KlT9E/8QpQSug+L7
         wjLyxTno0YCh6kw0rWCccNLcLI3GgAjfWVXbZpUBqoprSCeIVZ6aE6TfzkLRCcUTegdH
         iKZSXdN59RVQIyv/HyEkOnB0SKL20FY3UDxdFTqmQbk8uXWKHeNQrVXTfY7LZL+QwSeL
         AFgZeyL/xlz7NcJk7cxXGHjIZJnZXUZzcc5/8xV81xN+h0HB4Mzac7wrhAMt749EeyJs
         BaQS4toaGrxlqZfdKwMvlLXlw0zpipebDASSPWKm+jlW8F981d5QlSFGpI/5nTS426ah
         vR+A==
X-Gm-Message-State: AOJu0YwrUt0BV1Jy7VkkKLIRdyDSONCm5APVY7ikLf3DorcvukLMKfGw
	5AX9kokUssePITJpPp3RED6IhYHyR1M4oqdpwOrd6ixM+PGj3Nm8Yf/8/rrcM/7CpSb5o+87j33
	bkHGSg4xMfg2cK2sWGjCqBkOz06vdty22f4uWI2q+DxhlSbp/GdEg7A==
X-Gm-Gg: ATEYQzwWwzTUiyo20rabJcnVwj3uVs6B/z1kNtGu6OqvXNiTveqDzWX0IkzwSp/lT9t
	DOHan3rfFhBQ2GMOUnNvQsjbIkoza4BLTtMytjdb5qWPXPkirEhXStEo+/h03oV6bYWl9hHPaDU
	bYKizUHbH9ZSOFNCeMJJl2bUnBPKuyl1aBIlN4w9qf9vLQeHOsxaFEgJUiMQR/w1ONhzg5sLolq
	iyqhlKbzXOd4s2bYP+w6C1sSu3IJ5gbq+72DEgpVLispUSRvm3Z7hRVxZN9dF5623la4a20bjZT
	paJsorEGtdEno3rKHbU05NXufdfU0w==
X-Received: by 2002:aa7:908f:0:b0:82c:ebbd:9eca with SMTP id
 d2e1a72fcca58-82cebbdba6cmr2579095b3a.11.1775050236598; Wed, 01 Apr 2026
 06:30:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 1 Apr 2026 09:30:24 -0400
X-Gm-Features: AQROBzBVzmwXdf2WGM_n4Zy09fnWYZkggVAvYshhunotULUmqQbgAETJrZK1gAM
Message-ID: <CAM0EoMkHo-e5Smq2yi7c4HxA1dJWzXRYkOo0A6NmbF-HkzaAgQ@mail.gmail.com>
Subject: 0x1A: Dates And Location for upcoming conference
To: people <people@netdevconf.info>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>, Christie Geldart <christie@ambedia.com>, 
	Kimberley Jeffries <kimberleyjeffries@gmail.com>, LWN <lwn@lwn.net>, 
	"board@netdevconf.org" <board@netdevconf.info>, linux-wireless <linux-wireless@vger.kernel.org>, 
	netfilter-devel@vger.kernel.org, lartc@vger.kernel.org, 
	Stefano Salsano <stefano.salsano@uniroma2.it>, Andrea Mayer <andrea.mayer@uniroma2.it>, 
	Carlo Filippi <carlo@common-net.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274111-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,ambedia.com,gmail.com,lwn.net,netdevconf.info,uniroma2.it,common-net.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netdevconf.info:url,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mojatatu-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 84C3A37B5A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This is a pre-announcement so folks can plan travel etc.

Netdev conf 0x1A will be a hybrid conference.  We will update you with
the exact coordinates in the near future.
Either watch https://netdevconf.info/0x1A/ or join people@ mailing
list[1] for more frequent updates.

Netdev 0x1A is scheduled to be in Rome - Italy July 13th-16th.
Location: Universit=C3=A0 Roma TRE - Via Ostiense, 236, 00144 Rome RM, Ital=
y

Be ready to share your work with the community. CFS coming soon.

sincerely,
Netdev Society Board:
PJ, Roopa Prabhu, Shrijeet Mukherjee, Tom Herbert, Jamal Hadi Salim

[1] https://lists.netdevconf.info/postorius/lists/people.netdevconf.info/

