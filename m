Return-Path: <netdev+bounces-298169-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Xt8jEkLQKmqexQMAu9opvQ
	(envelope-from <netdev+bounces-298169-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 17:12:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA230672F84
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 17:12:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=QVFpcKSG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298169-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298169-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD48A30686D1
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 15:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244343F23C4;
	Thu, 11 Jun 2026 15:11:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609172FFFBE
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 15:11:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781190663; cv=pass; b=krHcQsXnayQuzmwoZUqsIxTiO45mv9b/3Q3l9JnUvdGOvLC935d4/VcedyT5Cadthtr0DFPCEP9b14iCzl+9eSSXRCrxF84XRb7a8OkbBUtDxfvByHqexUElJeLI7Akh1uUTGYRFlWNSn70sOF9xWQP7AYoMUn5LMGxBbBtDFQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781190663; c=relaxed/simple;
	bh=mqba1T9nauxNnwYVB0xz79JPbzcaMr3EFsx18vTPUkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OkRgELiZhMKSK6qP9L2tZD1sV6kXNSrW1PHOpRS3/K9uKBw1cAb/s40ZmbToRQ/kB2ayLHrlYXswr49U1nwFyYgyE7RKzsr/UkpfQaMUTCvfTE8v3xInoNkWjolPrcCQBNO7CN1EyBEoRc2ZWySasF+Bb3mnInMdVeqyWIv2Uqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QVFpcKSG; arc=pass smtp.client-ip=74.125.82.46
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-137dd523634so12724515c88.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 08:11:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781190659; cv=none;
        d=google.com; s=arc-20240605;
        b=EPAfHAVGnXLd+poOW/9ljABkj91IXVWkOVtZPYte3c56IQRTcP6oRIgpqWBSr+lKEf
         npwKc1PEfRdkVMbrzVAtQ8I0fgEoClWJmD9fg9LFPam9B7HQQVouvE+PY8pf5+rc6owT
         NS++yZSqVRl7aTnhQSpUiYMX+IriaoU6uNP7La+PSVGM/z8pOI704xzjLhpbq1JO04iL
         ZtE611MbEPne22kwp9xd2PgmebTkFwBvBRhHUGRh002Z0NOZF3D7IoaDoMXkz6EBjzeE
         YvD5AOmipiRdWtli876lnCGIQMeMZkNtRb4S4WLjlS02sp+ufwCnAIVi+Yr8IpvyThvP
         D5YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lxKXtOKyjTv+sAJ/+Fz+4at9+0jNf2gFTtOvWpxVwCw=;
        fh=l7UngGi+yr9Xx5IB4y3CnZ0Ko+xeeAKzgGV1n6+zrxg=;
        b=X186eRRyhJqNS1ZjVY9mmGrbTJdbulmf6+Wq/QzWxAizTTbJF1J8JBGOVPJdMAv/9i
         RYPxsnvMhXw6HXmPNvYH7zEsBacRJ1OiJPk87oehQjIkSWyM2Qkhrapvg8cavKz+z6Ui
         9qr9gD5MBFUxV/ZrPcf19eS0ZAyQTCievtzM3JSJJ0VyWQyP931kcWQKDtZ9TAmDX8Eg
         Eob7ajztMvQAWnfJhL747diHvgDOpRbktnPewafn1cagP9wpXNC1JM+VnShOclxuzQO6
         f5FhSeuqYuDYmYkxxrs6BkJ/bPwsa736WPJRfarCF5UcNyw8YUt9pd9CQ58Kamtp4Gzv
         fINw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781190659; x=1781795459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxKXtOKyjTv+sAJ/+Fz+4at9+0jNf2gFTtOvWpxVwCw=;
        b=QVFpcKSGE7vMkwgzeDGG47E8T2+BQD82hpGgIusIaUA4CDOjp66YYvby9aUVsRHxa/
         SbGokfSUZ0PBSd9mig6IraEuuwGCXYyFLgW1X1bCLzNikartw9Eh2plxCenQgHeGm6hG
         NMmSROF1yWrLofwvUFEKDUSebvbj9xk5VWIfb8oujvZsyCKlIGwgL+uw5HUqoP24jvbf
         yuM+bkrVdIlxgErkCROggsVhk+OEZ4WPxxcvCC85+EOqjKeEmI786DLYjdHgNc3LeaUf
         i2AGMHAZVSQBpxJeTvqZHv/nB7M46H7YN/K7HySXSfP9dCWhRrb1H31uyS3wT+WeXo3a
         O6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781190659; x=1781795459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lxKXtOKyjTv+sAJ/+Fz+4at9+0jNf2gFTtOvWpxVwCw=;
        b=MXnpFlDtlD0Yi2WYQ7Uyuv5G3LNISrJMiWTfMakCW03Y26qLysYh2v0DzIRnaL1wgI
         esNLqJUzzB9hKIIokAZe+ZIjziUDWiOwaOTswWlw6tXa4m3M/8I9YA4GL28ADV+3FUhA
         /6gNtSqj22Sb/nJA5KgshfA3nRtWQ5Xf2bwJwwMDc8Th5XDPZZAroldsS6M+zfhLcqw4
         m643cx437bm/m226pqTKPGqcs1h39mW6/ckVfkMZut5uzDyoDaeLUz9h3i9SBoy2C2NV
         VDeI1RvKQG1dywtyRwNGkdoCzPjRhcbqttMUbK4t6i1BfUTZkDpYy1PzSnpz4MHNi4EH
         7KYw==
X-Forwarded-Encrypted: i=1; AFNElJ/SW546C5eFUEwxaQJZy6GCi5j30R4HJBnIHueebiEdZzU+rMUbtftnf3M4Z2n5PkQkwUWGZwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiHxU7y/8A5paRy6szyo30b6XWn+X6BAZrWzC3yH8PNet6DEuz
	gy2ImdNwywKw6l/4Z5FuR3uSxpNC3OT0n6zf3shseYfumOZGIjrN1+0VxZ05UbAeHj8d8Zc+YgC
	lKjEppyvihEG7VUtVCbi71p/VuswgMariId10od+W
X-Gm-Gg: Acq92OHuac1cclnyFgUMi01RXxRc+6QPUt+aVe2Zg0vEn9LkzrPGHtPq8/rRpY/JzO+
	hwO28W/2NAEGiSRB2g1uoZj4wnhiV21+UqHtbNtKvEPjZcS70vmxnc7oeUZDY+VL+MFX7evY5Jr
	SBWcJni7PXWVcJEras0sya0EyYoiEXaj90HCc/giKK4phx+KK5LwuQwVNZebfbAzcL3wX4qW061
	7/y/jJL+n3t6fs+4sQ+i04oqKjQ+YoKWC+EtyluGmhFZIiTo/Cj6gPBW1o3ePjBVmo6woFQ0CZ9
	ydP9HOyr1PRFm+jvyNq4pFWD8SoxD8iLJdXaL8c2IOVBq/OQojg+GfDeW0c=
X-Received: by 2002:a05:701b:4552:20b0:138:44ab:75f7 with SMTP id
 a92af1059eb24-13844ab773cmr770322c88.21.1781190658662; Thu, 11 Jun 2026
 08:10:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611002437.1671401-1-digonzal@google.com>
In-Reply-To: <20260611002437.1671401-1-digonzal@google.com>
From: Brian Vazquez <brianvv@google.com>
Date: Thu, 11 Jun 2026 11:10:46 -0400
X-Gm-Features: AVVi8Cd9uZgzE9Vtr2KiKxKuSPVMf5kiWug4xcnQibRwcwPz9EwHUXafig-7Bv0
Message-ID: <CAMzD94SgL2QtQqu26icixW4MVL1D-UsauKbFF6qrtZ7TxCgNfA@mail.gmail.com>
Subject: Re: [PATCH iwl-net] idpf: decrease statistics refresh interval
To: Danny Gonzalez <digonzal@google.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Decotigny <decot@google.com>, Anjali Singhai <anjali.singhai@intel.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Li Li <boolli@google.com>, 
	emil.s.tantilov@intel.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:digonzal@google.com,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:decot@google.com,m:anjali.singhai@intel.com,m:sridhar.samudrala@intel.com,m:boolli@google.com,m:emil.s.tantilov@intel.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[brianvv@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-298169-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brianvv@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid,uso.py:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA230672F84

Tested-by: Brian Vazquez <brianvv@google.com>

Before patch:

# sar -n DEV 1  | grep eth1
08:09:51         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00
08:09:52         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00
08:09:53         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00
08:09:54         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00
08:09:55         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00
08:09:56         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00
08:09:57         eth1   4225.00   1801.00    736.18   1125.49
0.00      0.00      0.00      0.00
08:09:58         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00
08:09:59         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00
08:10:00         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00
08:10:01         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00
08:10:02         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00
08:10:03         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00
08:10:04         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00
08:10:05         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00
08:10:06         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00
08:10:07         eth1      0.00      0.00      0.00      0.00
0.00      0.00      0.00      0.00
08:10:08         eth1   3788.00   1435.00    628.26    535.24
0.00      0.00      0.00      0.00

After patch (you can now see background traffic reported right away!):

# sar -n DEV 1 | grep eth1
08:08:33         eth1    527.00    443.00    261.74     76.69
0.00      0.00      0.00      0.00
08:08:34         eth1    440.00    423.00    101.89     78.75
0.00      0.00      0.00      0.00
08:08:35         eth1    356.00    353.00     68.68     57.02
0.00      0.00      0.00      0.00
08:08:36         eth1    437.00    462.00    114.18    124.07
0.00      0.00      0.00      0.00
08:08:37         eth1    377.00    383.00     61.40     65.97
0.00      0.00      0.00      0.00
08:08:38         eth1    335.00    337.00     83.08     75.39
0.00      0.00      0.00      0.00
08:08:39         eth1    387.00    392.00     58.95     74.58
0.00      0.00      0.00      0.00
08:08:40         eth1    351.00    371.00     51.39    103.25
0.00      0.00      0.00      0.00
08:08:41         eth1    339.00    338.00     55.38     54.91
0.00      0.00      0.00      0.00
08:08:42         eth1    324.00    328.00     54.15     55.71
0.00      0.00      0.00      0.00


On Wed, Jun 10, 2026 at 8:24=E2=80=AFPM Danny Gonzalez <digonzal@google.com=
> wrote:
>
> The default 10s statistics refresh interval is too slow for real-time
> monitoring and causes network selftests (e.g., uso.py) to fail when
> verifying traffic immediately after transmission.
>
> A 10s delay also causes aliasing in telemetry tools polling at shorter
> intervals (e.g., 5s), leading to inaccurate rate calculations on
> high-throughput NICs.
>
> Decrease the refresh interval to 250ms to ensure fresh stats and fix
> test failures.
>
> Tested: drivers/net/hw:uso.py now passes
> Fixes: a251eee62133 ("idpf: add SRIOV support and other ndo_ops")
> Signed-off-by: Danny Gonzalez <digonzal@google.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_lib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/eth=
ernet/intel/idpf/idpf_lib.c
> index cf966fe6c759..e2890d219431 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> @@ -1364,7 +1364,7 @@ void idpf_statistics_task(struct work_struct *work)
>         }
>
>         queue_delayed_work(adapter->stats_wq, &adapter->stats_task,
> -                          msecs_to_jiffies(10000));
> +                          msecs_to_jiffies(250));
>  }
>
>  /**
> --
> 2.54.0.1099.g489fc7bff1-goog
>

