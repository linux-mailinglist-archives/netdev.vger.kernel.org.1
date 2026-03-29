Return-Path: <netdev+bounces-272883-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EogEXkRyWnktwUAu9opvQ
	(envelope-from <netdev+bounces-272883-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 13:48:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C651F351D5B
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 13:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 055FF3004DEF
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 11:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D711A175A7F;
	Sun, 29 Mar 2026 11:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F1RRsP3U";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bjiS84Gj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D21F9D9
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 11:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774784884; cv=none; b=fJs1rxM2fMNf3zaLEOranwTmw212niZGxO3LLzd7g67E+4OiBpcYucGUvTZGxgnD1TH/YrHLDGhBMbaEt/oQZrCIWhURMypXpLIHX1kXOd787cEh4YXmLt6C5/FRMqFPxDqFZqtn8ZoFfGf6R78KPeMjBuDpUmGpyOrolwfujSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774784884; c=relaxed/simple;
	bh=VmiU+lGWwhD04qd6rphG/xwilSYXtQMv9P8qHhzig6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uqABp+hK0rS7mMNIFBH2qIafDLV+CtinrIvrb3lD6rdIEzCeeFLrNAK7S4+JjXog2qk6L2fr+xTC8/eGvyEbzp4pORO35xbJI+QJyRRjCwrdsoIVjKoadNlQrPREXLV+Wf/n4Y1Ruhl7dzV6O8e5fxPgw0U+Wpcncu0XaZmPQrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F1RRsP3U; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bjiS84Gj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774784882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w4wyr6M+eJrZIrzyYJ1+8bLKHcISE+JsFI7+Bovqkkc=;
	b=F1RRsP3UmJRGBpQwH/CvC2ktWP8DpvesSP7xXLH8lPQpTJEWbgWyvm1EZ4xa4F5GmjFV0p
	eG/3hkq8XabWUaUeBfjZj/0bKmEK+m2P12uRv+J1+H+9erPvP00F1YMfnGt5tj3Z9EK9tp
	cleT5+qNHGqKv9gMIKcal8SGpKpNTng=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-s8haxHLjMbegueF2qxdytg-1; Sun, 29 Mar 2026 07:48:00 -0400
X-MC-Unique: s8haxHLjMbegueF2qxdytg-1
X-Mimecast-MFC-AGG-ID: s8haxHLjMbegueF2qxdytg_1774784879
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-486fc42c83aso26235975e9.0
        for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 04:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774784878; x=1775389678; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w4wyr6M+eJrZIrzyYJ1+8bLKHcISE+JsFI7+Bovqkkc=;
        b=bjiS84GjGtRZ+IZrZ5gAn20vN8SSKN0/CSeFzsWCruJyYRw06O3GIzYSNIUWluccsQ
         S0ZBlh2RFcShT3c2I9v17dc13lJmxU6XmK/aaUQ1on5nr8vW7bGFrCYjlWH0MNuuu9bH
         qQUcZY9dKBvfAt+cSEbx+52Iyt8eGnIRpQ4fIBUfCSS79h+vh/ZHv8yfnkbmTAc6Wobv
         +hStXgbD1YmjU437Z8o0kQV8xCmuW0Y+vii6gYxHc/B99I60SeiYFZBVTZCQ/T4hdCZ6
         ql7RDgxOsojZLHNHcbxFCouVfCVwokUCwaZH1Jq9e/C6YaRa72KODZmVaS5nl3MTcZXX
         fhrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774784878; x=1775389678;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w4wyr6M+eJrZIrzyYJ1+8bLKHcISE+JsFI7+Bovqkkc=;
        b=ejjtYS5CfJUUNirpT6gqMGyNpbIDzrUAefmNwVKOar6zoP4PHXzpV6ObxfYbSxcdEq
         GQ3jg2GB6rJ2zp22g16bZylNKKIDDYetZJXAFWmw+4vsq6s0MXut+Pb/v7kNOlSuSvG6
         Y+nk76WUHcZXUOrIs6DxKmQ3a8b8pUX1zZMrC4dAQMC8bsd3+2a6xKbRJxlnHMGq7xhe
         vdfp5SuGAWNNHQn7IjUwANK1wSZ8bK7Ig/pVsthnjjDPAg2FS/b+nA+ZgonQlFvDh2Ff
         G2qu2W+8/vgba49wiEUVchN4/8YcIAHXsfZZoNfpg1f/tb8mFYmWBV7akXBV1UTirWok
         mnIg==
X-Forwarded-Encrypted: i=1; AJvYcCXw+yyHveWf3INKy/G2A2/fuMCxoDDC3vYNdNuzOyqMrGMcOIi+gyuB2yP0VgcXqFir7mhd/ek=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyewzdAlzUVie/mPrbZ2ESCw582oh5Wr4PcanzhsGYWhhZYFY/
	AGdcSE4kRoSzQOY+4lh4vLUJeSjRa5MjMy12Fp0PiHGgcNPHMlkbL4Xs4jxWU8RGiKBW+U4bnLY
	G2M50J/wQoiqz5L0KPHzir9YUjrQWKF93IGO6FiFKyvYL7wuzF64nHGiWNL9dO4sczg==
X-Gm-Gg: ATEYQzyAs5Lz+gQTI3GFq9nKPG2Gow0zUxM1R/Xn4ZI9Td04fnPvVqNAzpIaSc+iewL
	3a7NaVmJ/4zL7ABBwEz76dYdpsM+Zow4CRJMGBR/OcbC34X9HzfdeVnkjQcllPVefNPoltmQ3Bx
	Qhj55136nQVqvzc89E2AWZf5arWdTCHD0gPVOhyOdgKPyOkDm1hTwa+ATMmaI3Wc5+5fjPeWkj2
	Y84QTVAJIiTeEOqLJNWPhf9rOPjcteSIVmeLz3JU5pSBvsmjAfOALfmzORDtn/USZbO+sSK4wBH
	gsSOgYD9okYgzhzmCKwmkRon8Lly1tvmru2jUCw1ZfoWSuRW3vVIrgPuFDwkhAYz6wr9tLyS56W
	xxbrALCUn4brlq6/av1gQ
X-Received: by 2002:a05:600c:8485:b0:487:36c:f5ab with SMTP id 5b1f17b1804b1-48727d73464mr164565785e9.10.1774784878159;
        Sun, 29 Mar 2026 04:47:58 -0700 (PDT)
X-Received: by 2002:a05:600c:8485:b0:487:36c:f5ab with SMTP id 5b1f17b1804b1-48727d73464mr164565445e9.10.1774784877645;
        Sun, 29 Mar 2026 04:47:57 -0700 (PDT)
Received: from [192.168.2.83] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf247102dsm14038435f8f.27.2026.03.29.04.47.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2026 04:47:56 -0700 (PDT)
Message-ID: <eb41d806-27e3-4b3b-9c83-95e0305d940b@redhat.com>
Date: Sun, 29 Mar 2026 13:47:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v2] dpll: Send object per event in JSON
 monitor mode
To: Vitaly Grinberg <vgrinber@redhat.com>, netdev@vger.kernel.org
Cc: stephen@networkplumber.org
References: <20260329-dpll-mon-j-v2-1-c8170a80e6d8@redhat.com>
Content-Language: en-US
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20260329-dpll-mon-j-v2-1-c8170a80e6d8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272883-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C651F351D5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Previously, monitor mode wrapped all events in a single JSON array
> inside a top-level object, which made piping the output to external
> tools (such as `jq`) impossible.
> Send a separate JSON object for each event in monitor mode,
> making the output suitable for line-by-line consumers. Skip the
> global JSON wrapper for monitor mode.
>
> Signed-off-by: Vitaly Grinberg <vgrinber@redhat.com>
> ---
> v2:
>    - Fixed indentation
> ---
>   dpll/dpll.c | 25 +++++++++++++++++--------
>   1 file changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/dpll/dpll.c b/dpll/dpll.c
> index 9893ca8c..49576d23 100644
> --- a/dpll/dpll.c
> +++ b/dpll/dpll.c
> @@ -571,8 +571,15 @@ int main(int argc, char **argv)
>   	argc -= optind;
>   	argv += optind;
>   
> -	new_json_obj_plain(json);
> -	open_json_object(NULL);
> +	/* Monitor emits one JSON object per event for streaming;
> +	 * other commands use a single JSON wrapper object.
> +	 */
> +	bool is_monitor = argc > 0 && strcmp(argv[0], "monitor") == 0;
> +
> +	if (!is_monitor) {
> +		new_json_obj_plain(json);
> +		open_json_object(NULL);
> +	}
>   
>   	/* Skip netlink init for help commands */
>   	bool need_nl = true;
> @@ -602,8 +609,10 @@ dpll_fini:
>   	if (need_nl)
>   		dpll_fini(dpll);
>   json_cleanup:
> -	close_json_object();
> -	delete_json_obj_plain();
> +	if (!is_monitor) {
> +		close_json_object();
> +		delete_json_obj_plain();
> +	}
>   dpll_free:
>   	dpll_free(dpll);
>   	return ret;
> @@ -2173,6 +2182,7 @@ static int cmd_monitor_cb(const struct nlmsghdr *nlh, void *data)
>   
>   		mnl_attr_parse(nlh, sizeof(struct genlmsghdr), attr_cb, tb);
>   
> +		new_json_obj_plain(json);
>   		open_json_object(NULL);
>   		print_string(PRINT_JSON, "name", NULL, json_name);
>   		open_json_object("msg");
> @@ -2182,6 +2192,7 @@ static int cmd_monitor_cb(const struct nlmsghdr *nlh, void *data)
>   
>   		close_json_object();
>   		close_json_object();
> +		delete_json_obj_plain();
>   		break;
>   	}
>   	case DPLL_CMD_PIN_CREATE_NTF:
> @@ -2200,6 +2211,7 @@ static int cmd_monitor_cb(const struct nlmsghdr *nlh, void *data)
>   			json_name = "pin-delete-ntf";
>   		}
>   
> +		new_json_obj_plain(json);
>   		open_json_object(NULL);
>   		print_string(PRINT_JSON, "name", NULL, json_name);
>   		open_json_object("msg");
> @@ -2209,6 +2221,7 @@ static int cmd_monitor_cb(const struct nlmsghdr *nlh, void *data)
>   
>   		close_json_object();
>   		close_json_object();
> +		delete_json_obj_plain();
>   		break;
>   	}
>   	default:
> @@ -2273,8 +2286,6 @@ static int cmd_monitor(struct dpll *dpll)
>   		goto err_signalfd;
>   	}
>   
> -	open_json_array(PRINT_JSON, "monitor");
> -
>   	pfds[0].fd = signal_fd;
>   	pfds[0].events = POLLIN;
>   	pfds[1].fd = netlink_fd;
> @@ -2307,8 +2318,6 @@ static int cmd_monitor(struct dpll *dpll)
>   		}
>   	}
>   
> -	close_json_array(PRINT_JSON, NULL);
> -
>   err_signalfd:
>   	if (signal_fd >= 0)
>   		close(signal_fd);
>
> ---
> base-commit: 36252727bfc653905bb39bec115a32869452beb1
> change-id: 20260328-dpll-mon-j-d88eb48c1f09
>
> Best regards,
> --
> Vitaly Grinberg <vgrinber@redhat.com>
>
>
Good idea, Thanks

Reviewed-by: Petr Oros <poros@redhat.com>



