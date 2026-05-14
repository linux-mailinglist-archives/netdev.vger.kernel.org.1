Return-Path: <netdev+bounces-288020-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cN27BV7pBWqPdQIAu9opvQ
	(envelope-from <netdev+bounces-288020-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 17:25:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80465543FC2
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 17:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7CCFF306195E
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 15:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D79F30648A;
	Thu, 14 May 2026 15:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLyy0a5d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6964E30276A
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 15:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778771751; cv=none; b=ST3OjEcJ0ULozdUjW1gzbNoudXrPmGRh15GPze6BpTGPwe+6R1mALiXO5lr5l0oMmQgzg3AIkVbvDWPSzMeGAZFJmZYvwzk5VRfKjLIuadSggPAfc+NM9Dq11rs0omvvEtewsOPJ5DNUEWsJmkt65WhvMOxXdzGjv6jslf6LsRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778771751; c=relaxed/simple;
	bh=uL/f5IMzb5Lis9p4zKgKRTpeiwojw3UgacWeySU3sic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vusa1XSjmAWcR3imEgnO9/3tTnD/Aun2AhSDt2j9gkBl52w7QZj7pUSEknxE7iis0uXaN8hTghK8qizXAKN2YEprBP8bwrGegnvMtw9DCfys5Cjv0MQEOsf1ZJYCaiW/kpowYO0GgSADQzvS6V8hQ/KMNvfJSoD+Va/LyIUCydc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLyy0a5d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9F0C2BCB3;
	Thu, 14 May 2026 15:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778771751;
	bh=uL/f5IMzb5Lis9p4zKgKRTpeiwojw3UgacWeySU3sic=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZLyy0a5dxm7+DXCPyBPBbQkA3Y22obVcNBPNFSCVHHeGZlC2gDxdcv7iSEKSLQp6l
	 u1lpNy5Q2FXvhDTLSg3vqq+2YG/tg+5UNJNvWG1n6BXx1Co+mVodAMh16DLM3nvvnT
	 QhPHAeQSLqUur+QyVU9c5IXJsT+E+oQvZ2bMcRVbTvOhpVi8AWsMiqTooaRj2cQyfy
	 cWKn0KqsJ2yphGAXwooSCs/zkqw1VgxszunJJQv1WYLEm9BdXTAPc3yf/FmGzBBpcF
	 ZofSMtQxXi+Va9NoLVyc5BR8gFpabXiO4TNaJ4EkIROuQCzwJS7wHIw5xbevpV+Mw1
	 MhNUHHKjcpCcw==
Message-ID: <9866a42a-98e8-4a34-9962-33ec0df4dcc3@kernel.org>
Date: Thu, 14 May 2026 09:15:49 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v3 5/6] netshaper: Add group command for
 creating scheduling hierarchies
Content-Language: en-US
To: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org
Cc: stephen@networkplumber.org, pabeni@redhat.com, kuba@kernel.org,
 ernis@linux.microsoft.com, alexanderduyck@gmail.com,
 Claude Assistant <noreply@anthropic.com>
References: <20260511183915.797792-1-mohsin.bashr@gmail.com>
 <20260511183915.797792-6-mohsin.bashr@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260511183915.797792-6-mohsin.bashr@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 80465543FC2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288020-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FREEMAIL_CC(0.00)[networkplumber.org,redhat.com,kernel.org,linux.microsoft.com,gmail.com,anthropic.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/11/26 12:39 PM, Mohsin Bashir wrote:
> @@ -319,6 +324,217 @@ static int do_cmd(int argc, char **argv, int cmd)
>  	return err;
>  }
>  
> +#define NET_SHAPER_MAX_LEAVES	256

why 256 as the limit? What drives a max value -- anything related to the
uapi? Will 256 ever be deemed too little? if not, why?

> +
> +static int do_group(int argc, char **argv)
> +{
> +	GENL_REQUEST(req, 4096, genl_family, 0, NET_SHAPER_FAMILY_VERSION,
> +		     NET_SHAPER_CMD_GROUP, NLM_F_REQUEST | NLM_F_ACK);
> +
> +	struct shaper_args args = SHAPER_ARGS_INIT;
> +	bool parsing_leaves = false, has_handle_id = false, has_parent_id = false;
> +	int parent_scope = -1, num_leaves = 0;
> +	int err, ret, handle_scope = NET_SHAPER_SCOPE_UNSPEC;
> +	__u32 handle_id = 0, parent_id = 0;
> +	struct nlmsghdr *answer;
> +
> +	struct {
> +		int scope;
> +		__u32 id;
> +	} leaves[NET_SHAPER_MAX_LEAVES];
> +
> +	while (argc > 0) {
> +		if (parsing_leaves) {


This while loop is really long. Move this parsing_leaves code to a
function and then drop the parsing_leaves flag.

> +			if (strcmp(*argv, "scope") == 0) {
> +				int lscope;
> +
> +				NEXT_ARG();
> +				lscope = parse_scope(*argv);
> +				if (lscope < 0) {
> +					fprintf(stderr, "Invalid leaf scope \"%s\"\n",
> +						*argv);
> +					return -1;
> +				}
> +				NEXT_ARG();
> +				if (strcmp(*argv, "id") != 0) {
> +					fprintf(stderr, "Expected \"id\" after leaf scope\n");
> +					return -1;
> +				}
> +
> +				NEXT_ARG();
> +				if (num_leaves >= ARRAY_SIZE(leaves)) {
> +					fprintf(stderr, "Too many leaves\n");
> +					return -1;
> +				}
> +				leaves[num_leaves].scope = lscope;
> +				if (get_unsigned(&leaves[num_leaves].id, *argv, 10)) {
> +					fprintf(stderr, "Invalid leaf id\n");
> +					return -1;
> +				}
> +				num_leaves++;
> +				argc--;
> +				argv++;
> +				continue;
> +			}
> +			parsing_leaves = false;
> +		}
> +
> +		ret = parse_shaper_arg(*argv, &argc, &argv, &args);
> +		if (ret < 0)
> +			return -1;
> +		if (ret > 0) {
> +			argc--;
> +			argv++;
> +			continue;
> +		}
> +
> +		if (strcmp(*argv, "handle") == 0) {
> +			NEXT_ARG();
> +			if (strcmp(*argv, "scope") != 0) {
> +				fprintf(stderr, "Expected \"scope\" after \"handle\"\n");
> +				return -1;
> +			}
> +			NEXT_ARG();
> +			handle_scope = parse_scope(*argv);
> +			if (handle_scope < 0) {
> +				fprintf(stderr, "Invalid handle scope \"%s\"\n",
> +					*argv);
> +				return -1;
> +			}
> +			if (handle_scope != NET_SHAPER_SCOPE_NODE &&
> +			    handle_scope != NET_SHAPER_SCOPE_NETDEV) {
> +				fprintf(stderr, "Group handle scope must be \"node\" or \"netdev\"\n");
> +				return -1;
> +			}
> +
> +			if (argc > 1 && strcmp(argv[1], "id") == 0) {
> +				NEXT_ARG();
> +				NEXT_ARG();
> +				if (get_unsigned(&handle_id, *argv, 10)) {
> +					fprintf(stderr, "Invalid handle id\n");
> +					return -1;
> +				}
> +				has_handle_id = true;
> +			}
> +		} else if (strcmp(*argv, "parent") == 0) {
> +			NEXT_ARG();
> +			if (strcmp(*argv, "scope") != 0) {
> +				fprintf(stderr, "Expected \"scope\" after \"parent\"\n");
> +				return -1;
> +			}
> +			NEXT_ARG();
> +			parent_scope = parse_scope(*argv);
> +			if (parent_scope < 0) {
> +				fprintf(stderr, "Invalid parent scope \"%s\"\n",
> +					*argv);
> +				return -1;
> +			}
> +			if (parent_scope != NET_SHAPER_SCOPE_NODE &&
> +			    parent_scope != NET_SHAPER_SCOPE_NETDEV) {
> +				fprintf(stderr, "Parent scope must be \"node\" or \"netdev\"\n");
> +				return -1;
> +			}
> +
> +			if (parent_scope == NET_SHAPER_SCOPE_NODE) {
> +				NEXT_ARG();
> +				if (strcmp(*argv, "id") != 0) {
> +					fprintf(stderr, "What is \"%s\"\n", *argv);
> +					usage();
> +					return -1;
> +				}
> +				NEXT_ARG();
> +				if (get_unsigned(&parent_id, *argv, 10)) {
> +					fprintf(stderr, "Invalid parent id\n");
> +					return -1;
> +				}
> +				has_parent_id = true;
> +			} else if (argc > 1 && strcmp(argv[1], "id") == 0) {
> +				NEXT_ARG();
> +				NEXT_ARG();
> +				if (get_unsigned(&parent_id, *argv, 10)) {
> +					fprintf(stderr, "Invalid parent id\n");
> +					return -1;
> +				}
> +				has_parent_id = true;
> +			}
> +		} else if (strcmp(*argv, "leaves") == 0) {
> +			parsing_leaves = true;
> +			argc--;
> +			argv++;
> +			continue;
> +		} else {
> +			fprintf(stderr, "What is \"%s\"\n", *argv);
> +			usage();
> +			return -1;
> +		}
> +		argc--;
> +		argv++;
> +	}
> +
> +	if (args.ifindex == -1)
> +		missarg("dev");
> +	if (handle_scope == NET_SHAPER_SCOPE_UNSPEC)
> +		missarg("handle");
> +	if (parent_scope < 0)
> +		missarg("parent");
> +	if (num_leaves == 0)
> +		missarg("leaves");
> +
> +	addattr32(&req.n, sizeof(req), NET_SHAPER_A_IFINDEX, args.ifindex);
> +
> +	struct rtattr *parent = addattr_nest(&req.n, sizeof(req),
> +					     NET_SHAPER_A_PARENT | NLA_F_NESTED);

no inline declarations.

Claude and Codex like to do this. If this code was co-authored by an AI
tool, please add the Assisted by tag (see
Documentation/process/coding-assistants.rst in the kernel repo). And if
that is true (code is co-authored by AI), drop the Reviewed-by tag.



