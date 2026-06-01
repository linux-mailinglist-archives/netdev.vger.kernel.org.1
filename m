Return-Path: <netdev+bounces-293913-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MQRHvIBHmoiggkAu9opvQ
	(envelope-from <netdev+bounces-293913-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 00:04:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E49625BF9
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 00:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3393930651D7
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 22:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3D0363C6A;
	Mon,  1 Jun 2026 22:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kZP7fhWC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62381351C2E
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 22:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780351319; cv=pass; b=Gc+ofAr73/KxjJr4PBGnZSZpYu4B9z5YC+VcMGhztmxjSQpfJdL9DpqkyRnnrGbOoWZ4F24R4IazR9oeemGlFKpudU/Qodms6crFLdaVwECHG61pwQKSpW/7lc1769aoeaa4qhixAMCW7MAny/lt+FC7yYd5KkaCQkKmtDw2iLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780351319; c=relaxed/simple;
	bh=Rw/4a/NURQMfsq8MHGhIKpn1A3GRmoCF9WKCmClKTZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p+IYg71tVbp9Mad0s8lsdtWl6JR6DiTJ1wsKfh4ORj2aS8kckGxmfwgx5Rxj7GIvu6YwcW1I749BftaHptuYb/IXYHwoFKLsvS6DaxgmGk4NdbLsTLnN4lT682tYvNxYGvBM+xUmfmRvPYdaSo1IZRT4x2LPBJm6s7Dumk4HBsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kZP7fhWC; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2bf22c18ad3so2555ad.0
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 15:01:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780351317; cv=none;
        d=google.com; s=arc-20240605;
        b=iZPxkJ8PBn0cdL4UkRWJDmq0bClBxOPXyHci5ku5DBu6vMgOj5qAjvT1CqpKK1eMKd
         IF8OVXeKX2XLEDrC/D8PVT22i9W3w2w8Y/gTYZ6zDEgN2APXsNq0ccR9LtOXjWxUc9g+
         J5LM330sGs1ZnjFZmM7AOQ0SwZVS9Yi4yeIYB5gUG1xKKRynjGh89Egdp5OAxt65LD4U
         w06cME2BlJ6wiow3fe90/n4UVQv1bry9xBzfWPYP69O8ZmB/lT8p0SFPsodGYZXfvAy8
         FrDsr8T15LwmTjhvz+W8Yw+WD9NP6N+NiN2kWcMlGnvzMy0hiQmu7XgCCvXtKUL6aZKZ
         23CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vF05xsD64swUE1S4mP39pcL6StP9wDO4XWqjCABBN+Q=;
        fh=Ef9lcZO4ZwrztREP42xReRHLmD9Hg2GQuFQd3HW9yBk=;
        b=CMOaELaSegnUVF9mU9x0Hds/SC2vsENLhTI1hJhEpemndwO3NKIAwWr2lslunNkYTH
         BdDLwrUbNWwSNmwkAhNvqCX1gpDYpcsixCZS04v6Kqqk/CcNcXzNNABl2nMD3T+Wq9Dx
         9I7ZpEXbCspg4tn5B2upCe63pHwisUlFNRppxPKwiM4NMV/1A0UjLUAtjHplFM1MuwSr
         VR+5QfmR6orQDppn0HMpAoeQEUNjcMjtHaycB438iWgL06EeXGUchsw+bqTYAqwpVtCq
         4a9TwxmIEXqogzyNutOWjeBUUFoNyYcuYIObM3BHDqcrtmk+VVo/Itvb45o7O1qA8CBc
         qWoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780351317; x=1780956117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vF05xsD64swUE1S4mP39pcL6StP9wDO4XWqjCABBN+Q=;
        b=kZP7fhWCFMd9s7ldpgtbmCwVvkWcwPnr2/xX3rDjUAvg4sageR5K4KzZOc5W/UHqOW
         ZFSNV/F3hFjedo4PB+ToOCKNq+ZHrNmLEPo7C0mntEQINc6uAqdIvO1GJV0/eSqkPn32
         dB9QBr3Zm1mNcTAdM9E/nGZYj58D93quYdfV6GnkKoojU7vHfof0lM9T4To02qlJHb/E
         eWX/iCkJ1TMrxdbZbo/I1PwC9+sNa8mOHGOmYKGH0YOhey2hb+Vy5IgQfbnAbig5sEMT
         3cQpB4YR0Zy09M+4Tbk5HAvkGoew7/Q2xjDpyf3tlEcDN+WKFB9ls6DwprKOWyuBcoO1
         CRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780351317; x=1780956117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vF05xsD64swUE1S4mP39pcL6StP9wDO4XWqjCABBN+Q=;
        b=Xz2YKFaDvXG3wo58vRA4qW/UXfubkvNhjZRkapgwv7MYP9E+x9JuSIgHptC79uWJEF
         KePwguVEblK91FpmT+2MpKFP6U6RvaDE8fXNtVNn9lkxIfFFAHs9Nc0A313YPXs4ae3t
         IB0f0NL3VRtpHpskwmVrju9qGAvrI62hp8xuna/lkl0rZCwyyFIr9mCA4r3rE0/x67Ch
         okoY7o4ycMWoNkjfQRSh8u3GBXqX7WGFeZfcHYv1PvW40utAfhlDJyrofYvqvCS5i07+
         /hzAmAS5gh0qNDXdBSv6GHVRx6efS6i5UpRYqSMENBCX6yUwMBr4sbOHcJD3dSWTRX1i
         6LEQ==
X-Gm-Message-State: AOJu0Yx3ej/+37UHNEn0ZSOIAUZQS7b9JsEgT2NrDSBFcH7LlU1aliZC
	ADGFPqJ5k4opBYT90GLFsWxXErf/zpsmgWH9gUCT7JmvOtRnWLA279UIj2N/5BsqGf/wvSNiAru
	xVXD7LCir+1p+Sj0S1hApBfGq4TmZGMMcaR/hpDi9U7853KbGNb9a5pq7Mq4=
X-Gm-Gg: Acq92OFxyp6SJge2sCK5ParjUmTsSn2arabvDL7q0aENYIsTkFlQ8ybWds/RZG4Ue4L
	C+xOzHOkFjKX1yfQg2c8Ulx3ULnYu2jiRfkE4DlEd+9XGqVYwUFcNDD3YA/vmzLYwjvz3kd/W41
	foWEd5nAUCwT3+E+ncwYamUN2ARaMLD1hEOwpv8lg9W3I+7vW6rCZrZSRrExb2c2AV1ZkOKjwMp
	tfRTxMvRlbiqexrOdsziUCr/IKv/+oh4jJA4WENOWfvFM3qGInLw533Vrw5URiDuvRY30N2MqTM
	rGzUCxf+rOkMnIwD2ctIChMy5WOSbytjUPScf7HV53O7q2CnK/DAhfO5nmVqiaKa1luVaiGk8pM
	xSIpyz5s5sk72VpU=
X-Received: by 2002:a17:902:ecc3:b0:2c0:bf57:8746 with SMTP id
 d9443c01a7336-2c10eb100e7mr1008545ad.18.1780351315809; Mon, 01 Jun 2026
 15:01:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601175437.3767283-1-hramamurthy@google.com>
In-Reply-To: <20260601175437.3767283-1-hramamurthy@google.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Mon, 1 Jun 2026 15:01:44 -0700
X-Gm-Features: AVHnY4KQyJtSfT5RIzZL1aSdVjjyck_NGH23XlGFpeG35bMFP6xN4cFz-7dZ_P4
Message-ID: <CAEAWyHf+G2ts+4Rs75mgVpqQpMa5fK=bdahZGRC0ay79D6U+8w@mail.gmail.com>
Subject: Re: [PATCH net-next 00/15] gve: AdminQ mode related refactors
To: netdev@vger.kernel.org
Cc: joshwash@google.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	sdf@fomichev.me, willemb@google.com, jordanrhee@google.com, 
	jfraker@google.com, nktgrg@google.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293913-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[18];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 02E49625BF9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 1, 2026 at 10:54=E2=80=AFAM Harshitha Ramamurthy
<hramamurthy@google.com> wrote:
>
> This series is preparing the driver for the addition of a new control
> plane mode(MailboxQ) by commonizing and reusing as much code as possible.
> MailboxQ is a new control plane infrastructure which uses mailbox queues.
> This is a new control plane to communicate with the device when the drive=
r
> is running on bare-metal instances as well as newer versions of the devic=
e.
>
> This series contains 2 main changes to the gve driver's existing control
> plane(AdminQ):
> 1) refactor some initialization/teardown path methods to make it work for
>    both control planes.
> 2) add gve_ctrl_ops structure to the driver for various control plane
>    operations
>
> The refactors are mainly around the init, reset and recover paths so that
> functionalities could be moved into the control ops like 'set_num_queues'=
,
> 'set_num_ntfy_blks' etc.
>
> This patch series only sets the control ops for AdminQ mode. This is
> intended as a preparation for adding MailboxQ mode in upcoming series
> which will add the new control plane infrastructure and then introduce
> the corresponding control ops for MailboxQ mode.
>
> The entire list of future patches can be found here for reference:
> https://github.com/hramamurthy12/linux/commits/gve-mailbox-queues/
>
> Harshitha Ramamurthy (9):
>   gve: don't pass in unused parameter to gve_adminq_free
>   gve: refactor initialization with helper functions
>   gve: introduce gve_adminq_get_device_properties()
>   gve: add a few helper functions to set device properties
>   gve: add struct gve_device_info to hold device properties
>   gve: introduce control plane operations structure
>   gve: introduce ctrl ops to set vectors and Qs
>   gve: refactor gve_init_priv for reset path
>   gve: add ctrl ops to for queue operations
>
> Joshua Washington (6):
>   gve: simplify reset logic
>   gve: add gve_ctrl_ops for gve initialization/teardown sequences
>   gve: split up notify block allocation and setup paths
>   gve: introduce new methods to handle IRQ doorbells
>   gve: setup and teardown management interrupts
>   gve: add link status/speed ctrl ops
>

Apply failure reproduced locally (patch 5 conflict).
Will send a rebased v2 after the 24h window.

Thanks,
Harshitha

>  drivers/net/ethernet/google/gve/gve.h         |  91 +-
>  drivers/net/ethernet/google/gve/gve_adminq.c  | 459 +++++++--
>  drivers/net/ethernet/google/gve/gve_adminq.h  |  25 +-
>  drivers/net/ethernet/google/gve/gve_dqo.h     |   2 +-
>  drivers/net/ethernet/google/gve/gve_ethtool.c |   5 +-
>  drivers/net/ethernet/google/gve/gve_main.c    | 876 +++++++++---------
>  6 files changed, 913 insertions(+), 545 deletions(-)
>
> --
> 2.54.0.669.g59709faab0-goog
>

