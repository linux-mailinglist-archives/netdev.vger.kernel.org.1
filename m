Return-Path: <netdev+bounces-288678-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDpJCUQsCWrIMAQAu9opvQ
	(envelope-from <netdev+bounces-288678-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 04:47:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9645455F0D5
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 04:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 970B33006F34
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 02:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494103264FA;
	Sun, 17 May 2026 02:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juliahub.com header.i=@juliahub.com header.b="HCrQ4ucG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A0E3033DF
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 02:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778986048; cv=pass; b=hvIqaXoWC/k73Mez2Dazl5/hb46EC078EXeYI+gYBrUFf2jKh+p5CZ7Wo40+Ior8sMOfO80gqBsquuxEYM1UK8AlDUW4P5PoM3jFeYblfvfDnnIFmOGKMMBznaWGAu5aZRGVitKZ/bmrEs8PhQJh4/ssoHrxFKWYXgNa56loyZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778986048; c=relaxed/simple;
	bh=NwBVwC/nBelyZLNFGRaOuxPA+RbK8oY+0phP6GfPT5w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=sOZ0uSuI1wLZFHcaRJp1gHcbdR8TYEsvqdN2RbsxFqJ/gtW8XRObBNSHB8z5atiMTI2jsxyCVP9e4Pj7bb3tQVPuX6dpefVSqRKlI+l+b5SxRILa79Ni+zsNdDdUtBq8Z3EVX5CTJcBPhEDuHZ6g88nvSzO9JQ0P8fceWi1lF2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=juliahub.com; spf=pass smtp.mailfrom=juliahub.com; dkim=pass (2048-bit key) header.d=juliahub.com header.i=@juliahub.com header.b=HCrQ4ucG; arc=pass smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=juliahub.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juliahub.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8b3fe2f19a4so14589206d6.2
        for <netdev@vger.kernel.org>; Sat, 16 May 2026 19:47:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778986045; cv=none;
        d=google.com; s=arc-20240605;
        b=LOBr4kOerUTUK4uZEqCXA3GI+mAv1s6WMXdZM32bhe0yyHNmttFj2IXzUrt2TBxBx1
         fTuptHQJDu2gHXzZURr5bCNoV5QJnLdsy5/aQ1SKF8VqK1Sz2JjIRzKaro63z6pBcqNF
         VIIz9KW3k4EWCAVrbJPiOJ4p4ohnEDkBOJUEu/mQi0LjrjFvCqWV8FxwM656jUBM8THt
         wI/gH8RCFblr4iI1Y/fSzppoTW1INzeAtV7f5Yrnpbashw0Izs9nVJOh3QKFgQn9mjdV
         lZLb6ot8t3A2s/rsiRbIprrhDHBu/veFSeIpjS9ZO2CVuItKL1ZI3IyW7epIixOKg5O3
         tQpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=GrCYpS1Kg2cJiBGT7t++xWTLkLpRUruScHyKB43nglE=;
        fh=gbAOgCEkbfTf3YT9FMHl1+nYYtyyC4ryU+XI5vFS+3c=;
        b=Rotc/BnIx+hb6M3oJT2xtrpM7HIAvciLJIPlT+78CCFu8eYPOCIVWlbxfBOt3lTyJe
         m8L6H6iqdfprj/66oaM4FV3U+rHY8dzfWho+yvfeqNzCojsoZ+EcyD2yqQIIRz9uGMNs
         vMKChvW5vGgpKeSDCOy1qi4XJFp18aQGvqQaa3aJlcTlV59ctl+Wmpr1o20IhqUK4gj+
         hW3IW/BKipdx/kfL2rKh4maHQSv0YKnDiFPY7mMeJSgNeXQ+DEqskbu1A6/7N1JWE+Gf
         f0sHDplRR9ZyIyZlW+dEACT64mRxl8w/LpBFE+zecE/Io1iflJLxOxhInCHF184/hoA9
         fbsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliahub.com; s=google; t=1778986045; x=1779590845; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GrCYpS1Kg2cJiBGT7t++xWTLkLpRUruScHyKB43nglE=;
        b=HCrQ4ucGXG4fzmWC+Iex8/FbINKaazXsEWH8F6KOEf8ffuKRAPzabV4OW2R93eRbXi
         sOOMLg/kjBTUo5VWJ5rPoCU/thRX7JlRX3YeNNnzRwtWYuhaTjvsipP7merlHqpV/mn0
         2Kwnktjh8MlQD/kBOpNZaMT/B+TUFBb99EoqxOKDFDxHDG2wmXNqWSPfIS4Bd0JLkOYo
         sza5Zx1l9Gt2qDW7MnqEnkK/x6GsmH56plUSx3cnoEqujqjBd0aXp8SoU/h2hCSVSeOa
         luIV051BmnkCPCeQn4E8byK7Ly2oVLHM5NzEV9Dy/VZn4HFKlWLw5vHWJs9b0MRamfGt
         DudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778986045; x=1779590845;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GrCYpS1Kg2cJiBGT7t++xWTLkLpRUruScHyKB43nglE=;
        b=ncNrePflpC+YpdOjoavmR/fh3V/iCdRVz0QGrJvNtjEAVU0rUzkpJKztFjqUqnSCHb
         9qrU9fRk3KccAu19YvaKR2AqYCEhdbiJYKUlCBzUQI+j/dpwCfOwSy5x8W9a3m34LaKC
         kD6IAi83zWglz6K81ii525XihdTCWPnaIQ7yQjWpwXzG6gi8bQPQetcgWDP5lOsLnThW
         OHiMqF5HvKLJt4cZ9sdmjN81bRcXigbuvrhEKjqQYDqYM73wzpt+EJNBViRbOlq/RmEF
         oJJTsNDmSwEBZrDrubNNHqA6fyLf+sP4cIS7rAIV/MKZIUxocnW7cUbvj13gBr/sW50q
         BpVg==
X-Gm-Message-State: AOJu0YxgeGq6x0xPjUaS5SxvIFLlk0HtKGy3fts+jRtKW2jhVtFVuwPa
	SoNCEZLsOm4hpoS8g83PRG1P9c0pYlUVgBjJfYQma7nJ2UzYul22HW8N2FcKrU2kk8S2c1EG2ko
	1coqPqULoaN9oRcyDZ22jjOJPKeFUCZzbrNRQeC8yIraiz5owxAYCCeA=
X-Gm-Gg: Acq92OEAtA3kOG3Jo8lL7iTM2krJTqbHdtyuIru4Fx2W5ZEyjeg/ursgVk2FfpEQqBp
	38uNDgMXVNmVAv2T9jAwsJ0AFAff5Q7kbS0egfKqrETk/TISMiIRdlYtcEPvNN1ku8jjMOjxuvR
	l9SLd9vCGDZcGKYy+W7bdne1V2Lauhi8tadWz04/bhZt/C3HT3Fs0bojcPCc7q37kOOcAKOO4+X
	xVk/v2/6pMU/AXCOSxOvkq8YT/9D1Xspv2hUAUPJ6EI3yd3OPAw2d+PD7TKfjPQukdPqDeTPcBm
	pqWCkyNThwtwbFvvKMlqyM9FM3xPcqBvPXCBPR0=
X-Received: by 2002:a05:6214:4d0a:b0:89f:2fa:a9bb with SMTP id
 6a1803df08f44-8ca0f601d65mr144415516d6.9.1778986045426; Sat, 16 May 2026
 19:47:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Keno Fischer <keno@juliahub.com>
Date: Sat, 16 May 2026 22:46:49 -0400
X-Gm-Features: AVHnY4L8EDHuD63E-Mxs3sfDoj0VJhXAuhAcDTlcw9J3gvSmNJzPVsn9PCPwujM
Message-ID: <CABV8kRzn=oewDQcv-_-WzktpxAuLBPiTgMdfcpyOYAnz=0kiDA@mail.gmail.com>
Subject: [BUG] mlxsw: Driver/Firmware disagreement about max headroom size
To: netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, mlxsw@nvidia.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 9645455F0D5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[juliahub.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[juliahub.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288678-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[juliahub.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[keno@juliahub.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello mlxsw maintainers,

I don't think this bug is particularly consequential, but there appears to be a
disagreement between the driver and the firmware regarding the proper max
headroom size. On my SN3800, I see the following:

 ```
$ tc qdisc replace dev swp1 root handle 1: prio bands 8 priomap 0 1 2 3 4 5 6 7
$ tc qdisc replace dev swp2 root handle 1: prio bands 8 priomap 0 1 2 3 4 5 6 7
$ dcb buffer set dev swp1 \
      buffer-size all:0 0:1219K \
      prio-buffer 0:0 1:0 2:0 3:0 4:0 5:0 6:0 7:0
Attribute write: No buffer space available
$ dcb buffer set dev swp2 \
      buffer-size all:0 0:1219K \
      prio-buffer 0:0 1:0 2:0 3:0 4:0 5:0 6:0 7:0
[78711.680961] mlxsw_spectrum2 0000:07:00.0: EMAD reg access failed
(tid=43b7c51f003ef26e,reg_id=500c(pbmc),type=write,status=7(bad
parameter))
Attribute write: I/O error
```

I don't know why this differs between the two switch ports, but since
the driver goes through a lot of effort to calculate the max value
and return a nice error (as shown in the first command), it seems
like a bug that it wouldn't do so on the second port.

As an aside, as a novice to this area, it wasn't clear to me from the
docs (https://github.com/Mellanox/mlxsw/wiki/Quality-of-Service),
whether the headroom buffer is a separate piece of memory or
whether it steals part of the shared buffer memory space, which
is what prompted me to just try various values here. It also wasn't
clear to me whether the headroom config did anything for lossy PGs.
Hope my naive view can help improve the page :).

Thanks,
Keno

